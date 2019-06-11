#!/bin/bash

#
# Multiline replace tool using sed.
#

readonly progname=$(basename $0)

# Display help message
getHelp() {
    cat << USAGE >&2

Usage: $progname [search] [replace] [input]

Examples:
    ml-replace.sh "$search" "$replace" input.txt > output.txt

USAGE
}

# At least three parameters areneeded
if [ $# -ne 3 ]; then
    getHelp
    exit 1
fi

#
search="$1"
replace="$2"
input="${3:--}"


# SYNOPSIS
#   quoteSearch <text>
#
# DESCRIPTION
#   Quotes (escapes) the specified literal text for use in a regular expression,
#   whether basic or extended - should work with all common flavors.
#
# sed doesn't support use of literal strings as replacement strings - it invariably 
# interprets special characters/sequences in the replacement string.
quoteSearch() {
    sed -e 's/[^^]/[&]/g; s/\^/\\^/g; $!a\'$'\n''\\n' <<<"$1" | tr -d '\n';
}


# SYNOPSIS
#  quoteReplace <text>
#
# DESCRIPTION
#  Quotes (escapes) the specified literal string for safe use as the substitution
#  string (the 'new' in `s/old/new/`).
#
# The search string literal must be escaped in a way that its characters aren't
# mistaken for special regular-expression characters.
quoteReplace() {
  IFS= read -d '' -r < <(sed -e ':a' -e '$!{N;ba' -e '}' -e 's/[&/\]/\\&/g; s/\n/\\&/g' <<<"$1")
  printf %s "${REPLY%$'\n'}"
}

# -> The newlines in multi-line input strings must be translated to '\n' strings, 
#    which is how newlines are encoded in a regex.
# -> $!a\'$'\n''\\n' appends string '\n' to every output line but the last (the
#    last newline is ignored, because it was added by <<<)
# -> tr -d '\n then removes all actual newlines from the string (sed adds one 
#    whenever it prints its pattern space), effectively replacing all newlines
#    in the input with '\n' strings.
# -> -e ':a' -e '$!{N;ba' -e '}' is the POSIX-compliant form of a sed idiom that
#    reads all input lines a loop, therefore leaving subsequent commands to operate
#    on all input lines at once.
#
# Sources from:
#    https://stackoverflow.com/questions/29613304/is-it-possible-to-escape-regex-metacharacters-reliably-with-sed/29613573#29613573
#    https://stackoverflow.com/questions/24890230/sed-special-characters-handling/24914337#24914337
sed -e ':a' -e '$!{N;ba' -e '}' -e "s/$(quoteSearch "$search")/$(quoteReplace "$replace")/" "$input"
