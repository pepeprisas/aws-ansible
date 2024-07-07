#!/usr/bin/env bash

# Example: ./appserver.sh -s ci
SCRIPT=$(basename ${0})
WHEREAMI=$( cd $(dirname $0) && pwd)

help() {
  echo ""
  echo "Script to configure appserver instances"
  echo ""
  echo "Syntax: "
  echo ""
  echo "appserver.sh -s <Stage> -e [extra_vars] -t [tags] -d [install_dir]"
  echo ""
  echo "Where: "
  echo "  -s <STAGE>          Stage of the environment."
  echo "  -e [extra vars]     Comma separated extra variables"
  echo "  -t [tags]           Playbook tags"
  echo "  -d [install_dir]    Custom install path. Default: /opt/appserver"
  echo ""
  echo "Example: ./appserver.sh -s dev -e instances=1,services=2 -t all"
  echo ""
  exit 1
}

# Parse options
while getopts "s:e:t:d:h" opts; do
  case "${opts}" in
    s) STAGE=${OPTARG} ;;
    e) EXTRAVARS=${OPTARG} ;;
    t) TAGS=${OPTARG} ;;
    d) INSTALLDIR=${OPTARG} ;;
    h) help ;;
    *) echo ${SCRIPT}
       exit 1 ;;
  esac
done
shift $((OPTIND-1))

# Validate parameters
if [ -z "${STAGE}" ]; then
  echo "Syntax ERROR!!!"
  help
  exit 1
else
  case "${STAGE}" in
    local)
      Stage='local'
      appserver_playbook=appserver.yml
      ;;
    eng)
      Stage=engineering
      appserver_playbook=appserver.yml
      ;;
    dev)
      Stage=development
      appserver_playbook=appserver-dev.yml
      ;;
    ci)
      Stage=integration
      appserver_playbook=appserver.yml
      ;;
    pre)
      Stage=preproduction
      appserver_playbook=appserver.yml
      ;;
    prod)
      Stage=production
      appserver_playbook=appserver.yml
      ;;
    *)
      echo $"Stage parameter must be: {local|eng|dev|ci|pre|prod}"
      exit 1
  esac
fi

if [ -z "${TAGS}" ]; then
  TAGS=all
fi

pushd ${WHEREAMI}
/usr/local/bin/ansible-playbook -v playbooks/appserver/$appserver_playbook -i inventory/appserver/$Stage --module-path=roles --vault-password-file vault_pass.txt --extra-vars "ansible_python_interpreter=$(which python) ${EXTRAVARS}" --tags=${TAGS}
popd
