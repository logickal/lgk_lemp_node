node default {

  class { 'apt':
    always_apt_update => true,
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
  
}

