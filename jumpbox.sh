#!/usr/bin/env bash
# Example: ./jumpbox.sh dev -s dev -e instances=1,services=2 -t all
SCRIPT=$(basename ${0})

help() {
  echo ""
  echo "Script to configure ansible Jumpbox"
  echo ""
  echo "Syntax: "
  echo ""
  echo "jumpbox.sh <Stage> [extra_vars] [tags]"
  echo ""
  echo "Where: "
  echo "  -s <STAGE>          Stage of the environment."
  echo "  -e [extra vars]     Comma separated extra variables."
  echo "  -t [tags]           Playbook tags"
  echo ""
  echo "Example: ./jumpbox.sh dev -s dev -e instances=1,services=2 -t all"
  echo ""
  exit 1
}

# Parse options
while getopts "s:e:t:h" opts; do
  case "${opts}" in
    s) STAGE=${OPTARG} ;;
    e) EXTRAVARS=${OPTARG} ;;
    t) TAGS=${OPTARG} ;;
    h) help ;;
    *) echo ${SCRIPT}
       exit 1 ;;
  esac
done
shift $((OPTIND-1))

# Validate parameters
if [ -z "${STAGE}" ]; then
  echo ${SCRIPT}
  exit 1
else
  case "${STAGE}" in
    dev)
      Stage=development
      playbook=jumpbox-dev.yml
      ;;
    ci)
      Stage=integration
      playbook=jumpbox.yml
      ;;
    eng)
      Stage=engineering
      playbook=jumpbox.yml
      ;;
    pre)
      Stage=preproduction
      playbook=jumpbox.yml
      ;;
    prod)
      Stage=production
      playbook=jumpbox.yml
      ;;
    *)
      echo $"Stage parameter must be: {dev|ci|eng|pre|prod}"
      exit 1
  esac
fi

if [ -z "${TAGS}" ]; then
  TAGS=all
fi

/usr/local/bin/ansible-playbook -v playbooks/jumpbox/$playbook -i inventory/jumpbox/$Stage --module-path=roles --tags=${TAGS} --extra-vars="${EXTRAVARS}" --vault-password-file vault_pass.txt
