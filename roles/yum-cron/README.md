Role Name
=========
Role to deploy yum-cron

Requirements
------------
None

Role Variables
--------------

Dependencies
------------

Example Playbook
----------------
ansible-playbook playbooks/<environment>/<environment>.yml --tags yum-cron
ansible-playbook playbooks/<environment>/<environment>.yml --tags yum-cron -i inventory/jumpbox/integration/hosts --vault-password-file=vault_pass.txt

License
-------
GLPv2

Author Information
------------------

An optional section for the role authors to include contact information, or a website (HTML is not allowed).
