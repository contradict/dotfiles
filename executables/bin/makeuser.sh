#!/bin/bash

if [ "${UID}" -ne "0" ]; then
    sudo $0 $@
    exit $?
fi

NEWUSER="${1}"
WHO=$(logname)
EXTRA_GROUPS=$(groups ${WHO} | \
    awk -v N=4 \
    '{sep="";\
      for (i=N; i<=NF; i++) { \
          printf("%s%s",sep,$i); \
          sep=","\
      }; \
      printf("\n")}')

PASSWORD=$(apg -n 1 -m 10 -x 15 -MSNCL -EO01Il -r /usr/share/dict/words)
CRYPTED_PASSWD=$(openssl passwd -1 ${PASSWORD})
useradd -m -p ${CRYPTED_PASSWD} ${NEWUSER}
usermod -a -G ${EXTRA_GROUPS} ${NEWUSER}
mkdir /home/${NEWUSER}/.ssh
curl -s https://gitlab.appliedinvention.com/${NEWUSER}.keys \
    -o /home/${NEWUSER}/.ssh/authorized_keys
if ! grep -q "You need to sign in or sign up before continuing." \
     /home/${NEWUSER}/.ssh/authorized_keys; then
    chmod 700 /home/${NEWUSER}/.ssh
    chmod 600 /home/${NEWUSER}/.ssh/authorized_keys
    chown -R ${NEWUSER} /home/${NEWUSER}/.ssh
else
    echo "No keys available"
    rm -rf /home/${NEWUSER}/.ssh
fi
echo ${NEWUSER}:${PASSWORD}
