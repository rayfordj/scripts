#!/bin/bash

case "${#}" in 
	0)
		find -not -empty -type f -printf "%s\n" | sort -rn | uniq -d | xargs -I{} -n1 find -type f -size {}c -print0 | xargs -0 md5sum | sort | uniq -w32 --all-repeated=separate
		;;
	1)
		find "${1}" -not -empty -type f -printf "%s\n" | sort -rn | uniq -d | xargs -I{} -n1 find "${1}"  -type f -size {}c -print0 | xargs -0 md5sum | sort | uniq -w32 --all-repeated=separate
		;;
	*)
		echo "Usage: $(basename ${0}) [directory]"
		;;
esac

