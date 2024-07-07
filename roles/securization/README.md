Role Name
=========

This role make some changes on the config of sysctl, sshd and cron to pass pentesting tests.

Requirements
------------

No Requirements

Role Variables
--------------

No role Variables

Dependencies
------------

None

Example Playbook
----------------

- hosts: processlauncher
  become: yes
  serial: 100%

  roles:

    - role: securization
      tags: [hosts]

   

License
-------

GLPv2


