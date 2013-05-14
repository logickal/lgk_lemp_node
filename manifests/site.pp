node default {

  stage { ['pre', 'post']: }

  Stage['pre'] -> Stage['main'] -> Stage['post']


  
  class { 'nginxphp::ppa': stage => 'pre' }

  package { 'nfsd':
    ensure => present
  }
  
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
                     "php5-mysql",
                     ],
  }

  include nginxphp::nginx



  nginxphp::fpmconfig {
    'vagrantphp':
      php_devmode => true,
      fpm_user => 'vagrant',
      fpm_group => 'vagrant',

  }

  nginxphp::nginx_addphpconfig { 'drupal.local':
    website_root => "/vagrant/webroot",
    default_controller => "index.php",
    require => Nginxphp::Fpmconfig['vagrantphp']
  }

  nginxphp::pear_addchannel { 'pear.drush.org':
  require => Package['php-pear']}

  nginxphp::pear_install {
    'drush/drush':
      require => [Nginxphp::Pear_addchannel['pear.drush.org']],
  }

  exec{ "drush-dl-registry-rebuild":
    command => "/usr/bin/drush dl registry_rebuild",
    require => [Nginxphp::Pear_install['drush/drush']]
  }
  

}
