#!/bin/bash


## String to search
#search=$(cat << 'END'
#IF(INSTALL_LAYOUT MATCHES "STANDALONE")
#  SET(prefix ".")
#  SET(bindir ${prefix}/${INSTALL_BINDIR})
#  SET(sbindir ${prefix}/${INSTALL_SBINDIR})
#  SET(scriptdir ${prefix}/${INSTALL_BINDIR})
#  SET(libexecdir ${prefix}/${INSTALL_SBINDIR})
#  SET(pkgdatadir ${prefix}/${INSTALL_MYSQLSHAREDIR})
#  SET(localstatedir ${prefix}/data)
#ELSE()
#  SET(prefix "${CMAKE_INSTALL_PREFIX}")
#  SET(bindir ${INSTALL_BINDIRABS})
#  SET(sbindir ${INSTALL_SBINDIRABS})
#  SET(scriptdir ${INSTALL_BINDIRABS})
#  SET(libexecdir ${INSTALL_SBINDIRABS})
#  SET(pkgdatadir ${INSTALL_MYSQLSHAREDIRABS})
#  SET(localstatedir ${MYSQL_DATADIR})
#ENDIF()
#END
#)

## String to replace with
#replace=$(cat << 'END'
#SET(prefix "${CMAKE_INSTALL_PREFIX}")
#SET(bindir ${prefix}/${INSTALL_BINDIR})
#SET(sbindir ${prefix}/${INSTALL_SBINDIR})
#SET(scriptdir ${prefix}/${INSTALL_BINDIR})
#SET(libexecdir ${prefix}/${INSTALL_SBINDIR})
#SET(pkgdatadir ${prefix}/${INSTALL_MYSQLSHAREDIR})
#SET(localstatedir ${MYSQL_DATADIR})
#END
#)

# String to search
search='IF(INSTALL_LAYOUT MATCHES "STANDALONE")
  SET(prefix ".")
  SET(bindir ${prefix}/${INSTALL_BINDIR})
  SET(sbindir ${prefix}/${INSTALL_SBINDIR})
  SET(scriptdir ${prefix}/${INSTALL_BINDIR})
  SET(libexecdir ${prefix}/${INSTALL_SBINDIR})
  SET(pkgdatadir ${prefix}/${INSTALL_MYSQLSHAREDIR})
  SET(localstatedir ${prefix}/data)
ELSE()
  SET(prefix "${CMAKE_INSTALL_PREFIX}")
  SET(bindir ${INSTALL_BINDIRABS})
  SET(sbindir ${INSTALL_SBINDIRABS})
  SET(scriptdir ${INSTALL_BINDIRABS})
  SET(libexecdir ${INSTALL_SBINDIRABS})
  SET(pkgdatadir ${INSTALL_MYSQLSHAREDIRABS})
  SET(localstatedir ${MYSQL_DATADIR})
ENDIF()'

# String to replace with
replace='SET(prefix "${CMAKE_INSTALL_PREFIX}")
SET(bindir ${prefix}/${INSTALL_BINDIR})
SET(sbindir ${prefix}/${INSTALL_SBINDIR})
SET(scriptdir ${prefix}/${INSTALL_BINDIR})
SET(libexecdir ${prefix}/${INSTALL_SBINDIR})
SET(pkgdatadir ${prefix}/${INSTALL_MYSQLSHAREDIR})
SET(localstatedir ${MYSQL_DATADIR})'

# Replace
../ml-replace.sh "$search" "$replace" input.txt > output.txt
