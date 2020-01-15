#!/bin/bash
set -ex

# Workaround: Ansible breaks if HOME is unset
if [ -z "$HOME" ]; then
    export HOME=$(cd ~; pwd)
fi

# Make sure packages are in place prior to run
RequiredPackages=(awscli lsof git wget ruby )
yum install -y "${RequiredPackages[@]}"

# ----------------------------------------------
# Variables
# ----------------------------------------------
aws_region=us-east-2
# ----------------------------------------------
# ** LIFECYCLE_EVENT = STOP **
# ----------------------------------------------
if [ "$LIFECYCLE_EVENT" = ApplicationStop ]; then

 whoami 

fi

# ----------------------------------------------
# ** LIFECYCLE_EVENT = BEFORE **
# ----------------------------------------------
if [ "$LIFECYCLE_EVENT" = BeforeInstall ]; then
set +e

 rpm -qa | grep ansible

if [ $? != 0 ]; then
  yum install -y wget
  wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
  yum install -y epel-release-latest-7.noarch.rpm
  yum install -y ansible
fi
 #
 # Purge directories 
 #
rm -rf /etc/ansible

set -e

fi

# ----------------------------------------------
# ** LIFECYCLE_EVENT = AFTER **
# ----------------------------------------------
if [ "$LIFECYCLE_EVENT" = AfterInstall ]; then

 ansible-playbook /etc/ansible/site.yml

fi

# ----------------------------------------------
# ** LIFECYCLE_EVENT = START **
# ----------------------------------------------
if [ "$LIFECYCLE_EVENT" = ApplicationStart ]; then

  whoami

fi
