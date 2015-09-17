# Homebrew (E)Nginx MySQL PHP Installer

Native way to setup web environment for Mac.

## Overview

This script will install and setup **Nginx** + **MySQL** + **PHP** + **Redis** + **Composer** + **Drush** through **Homebrew**.

## Requirements

* [Homebrew](http://mxcl.github.com/homebrew/)
 
## Installation
`curl -L https://raw.github.com/Happensit/Homebrew-getlooky/master/install.sh | bash`

## Usage
`getlooky [start | stop]`

## Creating VirtualHost
For example let's create virtual host for Drupal 'customsite'.

Copy Drupal preset:
`cp /usr/local/etc/nginx/sites-available/drupal.dev /usr/local/etc/nginx/sites-available/customsite.dev`
    
Change name and path to site: 
`vim /usr/local/etc/nginx/sites-available/customsite.dev`
    
    
    server {
      listen       80;
      server_name  mysite.local;
      root /Users/Happensit/Sites/customsite;

      access_log /usr/local/var/log/nginx/customsite.access.log;
      error_log  /usr/local/var/log/nginx/customsite.error.log;

      include /usr/local/etc/nginx/common/drupal;
    }

Enable virtual host:
`ln -s /usr/local/etc/nginx/sites-available/mysite.dev /usr/local/etc/nginx/sites-enabled/customsite.dev`

Add `127.0.0.1 customsite.dev` to `/etc/hosts`.

## Enable Xhprof with Drupal 7

    drush dl devel
    drush en devel
    drush vset devel_xhprof_directory "/usr/local/Cellar/php56-xhprof/254eb24"
    drush vset devel_xhprof_url "http://xhprof.dev"
    drush vset devel_xhprof_enabled 1

## Default Settings

### MySQL
Username: root

Password:

Port: 3306

### Xdebug
Remote port is 9002

## Configs

**Nginx**: `/usr/local/etc/nginx/nginx.conf`

**FastCGI**: `/usr/local/etc/nginx/fastcgi.conf`

**PHP**: `/usr/local/etc/php/5.6/php.ini`

**Redis**: `/usr/local/etc/redis.conf`

**Xdebug**: `/usr/local/etc/php/5.6/conf.d/ext-xdebug.ini`

**xhprof**: `/usr/local/etc/php/5.6/conf.d/ext-xhprof.ini`

Source code: `/usr/local/Cellar/php56-xhprof/`

**MySQL**: `/usr/local/etc/my.cnf`
