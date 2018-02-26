#!/bin/sh

if [ -z "${CNTLM_PROXY}" ]
then
        echo "CNTLM_PROXY can't be empty"
        exit 1
fi

cat << EOF > /cntlm.conf
Proxy       ${CNTLM_PROXY}
NoProxy     ${CNTLM_NO_PROXY}
Auth        ${CNTLM_AUTH}
Listen      0.0.0.0:3128
EOF

[ -n "${CNTLM_USERNAME}" ] && echo "Username    ${CNTLM_USERNAME}" >> /cntlm.conf
[ -n "${CNTLM_DOMAIN}" ] && echo "Domain      ${CNTLM_DOMAIN}" >> /cntlm.conf
[ -n "${CNTLM_PASSWORD}" ] && echo "Password    ${CNTLM_PASSWORD}" >> /cntlm.conf
[ -n "${CNTLM_PASSNTLMV2}" ] && echo "PassNTLMv2      ${CNTLM_PASSNTLMV2}" >> /cntlm.conf
[ -n "${CNTLM_PASSNT}" ] && echo "PassNT      ${CNTLM_PASSNT}" >> /cntlm.conf
[ -n "${CNTLM_PASSLM}" ] && echo "PassLM      ${CNTLM_PASSLM}" >> /cntlm.conf

cntlm -f -v -c /cntlm.conf $*
