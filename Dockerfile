# Use phusion/baseimage as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/baseimage-docker/blob/master/Changelog.md for
# a list of version numbers.
FROM phusion/baseimage
MAINTAINER Dane Powell

# Set up environment
ENV HOME /root
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
RUN echo %sudo	ALL=NOPASSWD: ALL >> /etc/sudoers

# Install packages.
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y apache2 mysql-server php5-mysql libapache2-mod-php5 php5-gd php5-curl pwgen

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Expose ports.
EXPOSE 80

# Add services.
ADD apache2.sh /etc/service/apache2/run
ADD mysqld.sh /etc/service/mysqld/run

# Set up Drupal installation.
ADD settings.local.php /root/settings.local.php
ADD start.sh /etc/my_init.d/start.sh

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
