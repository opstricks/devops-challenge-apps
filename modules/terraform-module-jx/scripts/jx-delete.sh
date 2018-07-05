#/bin/sh

if `helm list jxing      > /dev/null`; then echo -e "\033[1;36m"; helm delete jxing     --purge; fi
if `helm list jenkins-x  > /dev/null`; then echo -e "\033[1;36m"; helm delete jenkins-x --purge; fi
if `helm list            > /dev/null`; then echo -e "\033[1;36m"; helm reset            --force; fi
if [ `kubectl get namespace jx > /dev/null` ]; then  echo -e "\033[1;36m"; kubectl delete namespace jx ; fi
if `ls ~/.jx > /dev/null`  ; then rm ~/.jx   -rf && echo -e "\033[1;36m Deleted ~/.jx  "; fi
if `ls ~/.helm > /dev/null`; then rm ~/.helm -rf && echo -e "\033[1;36m Deleted ~/.Helm"; fi