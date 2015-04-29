#!/bin/bash
#
#  TODO: potential to expand this, but suites my needs for now
#
IN="$1"
SHANAME=$(sha1sum ${IN} | cut -d" " -f1)
EXT="${IN:(-4)}"
# Change SHADIR to where you'd like to save the hashed-name copy \
#    or else it'll create a directory in the current directory \
#    executed
SHADIR="SHA1-filenames/"
OUT="${SHADIR}${SHANAME}${EXT}"

if [ ! -d ${SHADIR} ]; then
  /bin/mkdir ${SHADIR}
fi

if [ ! -f ${OUT} ]; then
  /bin/cp -v ${IN} ${OUT}
fi
