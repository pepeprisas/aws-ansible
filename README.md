# aws-ansible

## Checkout code directly on EC2 instances and run shell scripts in order to execute ansible playbooks
## -s parameter for setting environment
## -t for selecting specific playbook tags/roles ("all" for all roles)

### Example: ./appserver.sh -s dev -t all
### Example: ./jumpbox.sh -s prod -t yum_repos,sshd,jumpbox