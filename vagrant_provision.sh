#!/bin/bash

DOMAIN="customerportal3.opbdev.net"


echo "Provisioning Rapture VM $DOMAIN ..."


## set up the .netrc and ssh's authorized_keys
##echo "machine fisheye.team-center.net login qatest password brillodelS0l1" > /home/vagrant/.netrc
##chown vagrant:vagrant /home/vagrant/.netrc
cat /vagrant/.admin/authorized_keys >> /home/vagrant/.ssh/authorized_keys

## We need epel-release for php-mcrypt
yum -y install epel-release
yum -y install git php php-mcrypt vim mod_ssl man telnet perl-Template-Toolkit
yum -y install mlocate

yum -y install perlbrew
perlbrew init
source ~/perl5/perlbrew/etc/bashrc
perlbrew install perl-5.20.2
perlbrew switch perl-5.20.2

perl -V


yum -y install perl-XML-LibXSLT
yum -y install mod_perl




## Create directories for the site to live in.
[[ -d /opt/httpd/vhosts/$DOMAIN/logs ]] || mkdir -p /opt/httpd/vhosts/$DOMAIN/logs
[[ -d /opt/httpd/vhosts/$DOMAIN/certs ]] || mkdir -p /opt/httpd/vhosts/$DOMAIN/certs
[[ -d /opt/httpd/vhosts/$DOMAIN/www/htdocs ]] || mkdir -p /opt/httpd/vhosts/$DOMAIN/www/htdocs


# cert
[[ -L /opt/httpd/vhosts/$DOMAIN/certs/cert.pem ]] || ln -s /vagrant/.admin/cert.pem /opt/httpd/vhosts/$DOMAIN/certs/
# key
[[ -L /opt/httpd/vhosts/$DOMAIN/certs/privkey.pem ]] || ln -s /vagrant/.admin/privkey.pem /opt/httpd/vhosts/$DOMAIN/certs/
# ca cert
[[ -L /opt/httpd/vhosts/$DOMAIN/certs/ca.crt ]] || ln -s /vagrant/.admin/ca.crt /opt/httpd/vhosts/$DOMAIN/certs/
# ca cert bundle
[[ -L /opt/httpd/vhosts/$DOMAIN/certs/ca-bundle.crt ]] || ln -s /vagrant/.admin/ca-bundle.crt /opt/httpd/vhosts/$DOMAIN/certs/

## set up the apache config file. the zzz at the beginning, ensures that SSL is loaded before hand
[[ -L /etc/httpd/conf.d/zzz$DOMAIN.httpd.conf ]] || ln -s /vagrant/zzz$DOMAIN.httpd.conf /etc/httpd/conf.d/


## create links to the git clone
# application dir
#[[ -L /opt/httpd/vhosts/$DOMAIN/www/htdocs/application ]] || ln -s /vagrant/application /opt/httpd/vhosts/$DOMAIN/www/htdocs/

# assets dir
#[[ -L /opt/httpd/vhosts/customerportal2.verioqa.com/www/htdocs/assets ]] || ln -s /vagrant/assets /opt/httpd/vhosts/customerportal2.verioqa.com/www/htdocs/






## make sure vagrant can edit/read all of the site
chown -R vagrant:vagrant /opt/httpd/vhosts/$DOMAIN/

## (re)start apache
/sbin/service httpd restart


