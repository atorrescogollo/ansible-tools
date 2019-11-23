#!/bin/bash

WORKDIR=${1:-.}
WORKDIR=$(realpath ${WORKDIR})

if [ $# -gt 1 ]||[ ! -d "$WORKDIR" ]
then
        2>&1 echo "Usage: mk-ansible-workspace [<workspace directory>]"
        exit 1
fi
if [ "$(ls -A ${WORKDIR})" ]
then
        2>&1 echo "${WORKDIR} is not empty!"
        exit 1
fi

echo "# Production Servers" > ${WORKDIR}/production.inventory
echo "# Staging Servers" > ${WORKDIR}/staging.inventory

mkdir -p "${WORKDIR}/group_vars/"
echo "# Assign variables to particular groups" > ${WORKDIR}/group_vars/group1.yaml
echo "# Assign variables to particular groups" > ${WORKDIR}/group_vars/group2.yaml
mkdir -p "${WORKDIR}/host_vars/"
echo "# Assign variables to particular server" > ${WORKDIR}/host_vars/hostname1.yaml
echo "# Assign variables to particular server" > ${WORKDIR}/host_vars/hostname2.yaml

echo "# Master Playbook" > ${WORKDIR}/site.yaml
echo "# Playbook for Webserver tier" > ${WORKDIR}/webservers.yaml

mkdir -p "${WORKDIR}/roles"

if [ -f "./mk-ansible-role.sh" ]
then
	mkrole="bash mk-ansible-role.sh"
else
	mkrole="mk-ansible-role"
fi

${mkrole} ${WORKDIR} common

tree ${WORKDIR}
