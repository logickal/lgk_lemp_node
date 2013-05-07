node default {

  class { 'apt':
    always_apt_update => true,
  }

  class {'git':
  }

  class { 'nginx':
  }

  class { 'php_fastcgi':
    user => 'vagrant',
    group => 'vagrant',
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

  nginx::resource::vhost {
    'localhost':
      ensure => present,
      www_root => '/vagrant/webroot',
  }
}

