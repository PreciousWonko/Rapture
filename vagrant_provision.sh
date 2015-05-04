#!/bin/bash

echo "provisioning Rapture VM..."

## set up the .netrc and ssh's authorized_keys
echo "machine fisheye.team-center.net login qatest password brillodelS0l1" > /home/vagrant/.netrc
chown vagrant:vagrant /home/vagrant/.netrc
cat /vagrant/.admin/authorized_keys >> /home/vagrant/.ssh/authorized_keys

## We need epel-release for php-mcrypt
yum -y install epel-release
yum -y install git php php-mcrypt vim mod_ssl man telnet perl-Template-Toolkit

## Create directories for the site to live in.
[[ -d /opt/httpd/vhosts/customerportal2.verioqa.com/logs ]] || mkdir -p /opt/httpd/vhosts/customerportal2.verioqa.com/logs
[[ -d /opt/httpd/vhosts/customerportal2.verioqa.com/certs ]] || mkdir -p /opt/httpd/vhosts/customerportal2.verioqa.com/certs
[[ -d /opt/httpd/vhosts/customerportal2.verioqa.com/www/htdocs ]] || mkdir -p /opt/httpd/vhosts/customerportal2.verioqa.com/www/htdocs

## create links to the git clone
# application dir
[[ -L /opt/httpd/vhosts/customerportal2.verioqa.com/www/htdocs/application ]] || ln -s /vagrant/application /opt/httpd/vhosts/customerportal2.verioqa.com/www/htdocs/
# assets dir
[[ -L /opt/httpd/vhosts/customerportal2.verioqa.com/www/htdocs/assets ]] || ln -s /vagrant/assets /opt/httpd/vhosts/customerportal2.verioqa.com/www/htdocs/
# system dir
[[ -L /opt/httpd/vhosts/customerportal2.verioqa.com/www/system ]] || ln -s /vagrant/system /opt/httpd/vhosts/customerportal2.verioqa.com/www/system
# index.php
[[ -L /opt/httpd/vhosts/customerportal2.verioqa.com/www/htdocs/index.php ]] || ln -s /vagrant/index.php /opt/httpd/vhosts/customerportal2.verioqa.com/www/htdocs/
# .htaccess
[[ -L /opt/httpd/vhosts/customerportal2.verioqa.com/www/htdocs/.htaccess ]] || ln -s /vagrant/.htaccess /opt/httpd/vhosts/customerportal2.verioqa.com/www/htdocs/
# cert
[[ -L /opt/httpd/vhosts/customerportal2.verioqa.com/certs/cert.pem ]] || ln -s /vagrant/.admin/cert.pem /opt/httpd/vhosts/customerportal2.verioqa.com/certs/
# key
[[ -L /opt/httpd/vhosts/customerportal2.verioqa.com/certs/privkey.pem ]] || ln -s /vagrant/.admin/privkey.pem /opt/httpd/vhosts/customerportal2.verioqa.com/certs/
# ca cert
[[ -L /opt/httpd/vhosts/customerportal2.verioqa.com/certs/ca.crt ]] || ln -s /vagrant/.admin/ca.crt /opt/httpd/vhosts/customerportal2.verioqa.com/certs/
# ca cert bundle
[[ -L /opt/httpd/vhosts/customerportal2.verioqa.com/certs/ca-bundle.crt ]] || ln -s /vagrant/.admin/ca-bundle.crt /opt/httpd/vhosts/customerportal2.verioqa.com/certs/

## set up the apache config file. the zzz at the beginning, ensures that SSL is loaded before hand
[[ -L /etc/httpd/conf.d/zzzCustomerPortal2.httpd.conf ]] || ln -s /vagrant/zzzCustomerPortal2.httpd.conf /etc/httpd/conf.d/

## make sure vagrant can edit/read all of the site
chown -R vagrant:vagrant /opt/httpd/vhosts/customerportal2.verioqa.com/

## (re)start apache
/sbin/service httpd restart


