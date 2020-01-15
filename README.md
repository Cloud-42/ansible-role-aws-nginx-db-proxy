# ansible-role-aws-nginx-db-proxy
Ansible role that can be used with CodeDeploy to setup Nginx as a database proxy.

This module is designed to be used with CodeDeploy so includes the various file and configurations required for CodeDeploy. Appspec.yml for example. It is assumed this will be deployed onto a host running a RedHat derivative, for other OSes updates would be required. 
