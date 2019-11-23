#!/bin/bash

case $# in
        1)
                WORKDIR="."
                ROLENAME=$1
        ;;
        2)
                WORKDIR=$1
                ROLENAME=$2
        ;;
        *)
                2>&1 echo "Usage: mk-ansible-role [<workspace directory>] [<role name>]"
                return
        ;;
esac

WORKDIR=$(realpath ${WORKDIR})

if [ ! -d "$WORKDIR" ]||[ ! "$(ls -A ${WORKDIR})" ]||[ ! -d "${WORKDIR}/roles" ]
then
        2>&1 echo "Usage: mk-ansible-role [<workspace directory>] [<role name>]"
        return
fi

ROLEDIR="${WORKDIR}/roles/${ROLENAME}"
if [ -e "${ROLEDIR}" ]
then
        echo "${ROLENAME} role already exists (${ROLEDIR})"
        return
fi

mkdir -p "${ROLEDIR}/tasks"
echo "# Tasks File" > "${ROLEDIR}/tasks/main.yaml"

mkdir -p "${ROLEDIR}/handlers"
echo "# Handlers File" > "${ROLEDIR}/handlers/main.yaml"

mkdir -p "${ROLEDIR}/templates"
echo "# Template File" > "${ROLEDIR}/templates/template.txt.j2"

mkdir -p "${ROLEDIR}/files"
echo "# Data File" > "${ROLEDIR}/files/file.txt"

mkdir -p "${ROLEDIR}/vars"
echo "# Rol variables" > "${ROLEDIR}/vars/main.yaml"

mkdir -p "${ROLEDIR}/defaults"
echo "# Rol default variables" > "${ROLEDIR}/defaults/main.yaml"

mkdir -p "${ROLEDIR}/meta"
echo "# Rol dependencies" > "${ROLEDIR}/meta/main.yaml"

echo "Role created: ${ROLEDIR}"

