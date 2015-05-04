#!/bin/bash

echo "Starting Rapture VM..."

yum -y update
if rpm -qa | grep -qw httpd; then
    /sbin/service httpd restart
fi
