# Homebrew (E)Nginx MySQL PHP Installer

Native way to setup web environment for Mac.

![brew-emp](brew-emp.png)

## Overview

This script will install and setup **Nginx** + **MySQL** + **PHP** through **Homebrew**.

## Requirements

* [Homebrew](https://github.com/Happensit/Homebrew-getlooky)
 
## Installation
`curl -L https://raw.github.com/Happensit/Homebrew-getlooky/master/install.sh | bash`

## Usage
`getlooky [start | stop]`

## Creating VirtualHost
For example let's create virtual host for Drupal 'mysite'.

Copy Drupal preset:
`cp /usr/local/etc/nginx/sites-available/drupal.local /usr/local/etc/nginx/sites-available/mysite.local`
    
Change name and path to site: 
`vim /usr/local/etc/nginx/sites-available/mysite.local`
    
    
    server {
      listen       80;
      server_name  mysite.local;
      root /Users/Happensit/Sites/customsite;

      access_log /usr/local/var/log/nginx/customsite.access.log;
      error_log  /usr/local/var/log/nginx/customsite.error.log;

      include /usr/local/etc/nginx/common/drupal;
    }

Enable virtual host:
`ln -s /usr/local/etc/nginx/sites-available/mysite.local /usr/local/etc/nginx/sites-enabled/mysite.local`

Add `127.0.0.1 mysite.local` to `/etc/hosts`.

## Enable Xhprof with Drupal 7

    drush dl devel
    drush en devel
    drush vset devel_xhprof_directory "/usr/local/Cellar/php54-xhprof/254eb24"
    drush vset devel_xhprof_url "http://xhprof.local"
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

**PHP**: `/usr/local/etc/php/5.4/php.ini`

**Redis**: `/usr/local/etc/redis.conf`

**Xdebug**: `/usr/local/etc/php/5.4/conf.d/ext-xdebug.ini`

**xhprof**: `/usr/local/etc/php/5.4/conf.d/ext-xhprof.ini`

Source code: `/usr/local/Cellar/php54-xhprof/`

**xhgui**: `/usr/local/Cellar/php54-xhgui/ee00acb/web/config/config.php`

**MySQL**: `/usr/local/etc/my.cnf`