#!/bin/bash
#
# Download ISO content from RH and name the file correctly

# TODO: Review for improvements
# ## This was thrown together quickly and likely has room for \
# ##    many enhancements, but it did what I needed when I needed \
# ##    and I've not come back to it sense.  Probably won't until \
# ##    I need it (or similar functionality) again...

# perform sha256sum verification?
# VERIFY=[y|n]
VERIFY=y

# set proxy vars if needed
# examples
#http_proxy="http://localhost:3128/"
#https_proxy="http://localhost:3128/"
#
#export https_proxy="http://localhost:8080/"

if [ "${#}" -lt 1 ]; then
    echo "Usage: $(basename ${0}) ...URLs..."
fi

function verify-file()
{
    echo -n "Results:  "
    echo -n "${SHA}  ${NAME}" | sha256sum -c 
    SHAEXIT="$?"
    return ${SHAEXIT}
}

function dl-file()
{
    wget --no-check-certificate -O ${NAME} -c ${VAR}
}

for VAR in "${@}"
do
    NAME="$(echo "${VAR}" | sed -e 's|^htt.*/\(.*\)?.*$|\1|g')"
    SHA="$( echo "${VAR}" | sed -e 's|^htt.*/\([a-f0-9]\{64\}\)/.*$|\1|g')"
    SHAEXIT='0'

    if [ "${VERIFY}" == "y" ]; then
        if [ -f "${NAME}" ]; then
            echo "Verifying: ${NAME}"
            verify-file 
        fi
        if [ "${SHAEXIT}" -gt 0 ]; then
            dl-file
        else
            continue
        fi
    else
        dl-file
    fi
    if [ "${VERIFY}" == "y" ]; then
        echo "Verifying: ${NAME}"
        verify-file
        if [ "${SHAEXIT}" -gt 0 ]; then
            rm -fv "${NAME}"
            dl-file
        else
            continue
        fi
        echo "Verifying: ${NAME}"
        verify-file
        if [ "${SHAEXIT}" -gt 0 ]; then
            dl-file
        else
            continue
        fi
        echo "Verifying: ${NAME}"
        verify-file
        if [ "${SHAEXIT}" -gt 0 ]; then
            echo; echo; echo;
            echo "Aborting for ${NAME}.  Continued verification failures."
            echo "Manual intervention required to correct"
            echo; echo; echo;
            sleep 5;
        else
            continue
        fi
    fi
done


