node default {

  stage { ['pre', 'post']: }
  
  Stage['pre'] -> Stage['main'] -> Stage['post']
  
  class { 'apt':
    always_apt_update => true,
    stage => 'pre'
  }

  apt::ppa { "ppa:ondrej/php5": }
  apt::key { "ondrej": key => "E5267A6C" }

  class {'git':
  }

  class { 'mysql':
  }

  class { 'mysql::server':
    config_hash => {'root_password' => 'root'}
  }

  mysql::db {
    'localdb':
      user => 'mysqluser',
      password => 'password',
      host => 'localhost',
      grant => ['all'],
  }

  include nginxphp


  
  class { 'nginxphp::php':
    php_packages => [
                     "php5-curl",
                     "php5-gd",
                     "php5-xcache",
                     "php5-xmlrpc",
                     ],


  }

  include nginxphp::nginx

  include nginxphp::phpdev

  nginxphp::fpmconfig {
    'vagrantphp':
      php_devmode => true,
      fpm_user => 'vagrant',
      fpm_group => 'vagrant',
      
  }

  nginxphp::nginx_addphpconfig { 'localhost':
    website_root => "/vagrant/webroot",
    default_controller => "index.php",
    require => Nginxphp::Fpmconfig['vagrantphp']
  }
}




