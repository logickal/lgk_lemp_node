node default {

  exec {'apt-get update':
    command => '/usr/bin/apt-get update'
  }
  class {'git': }

  file { '/usr/lib/node_modules':
    ensure => "directory",
    owner => 'root',
    group => 'admin',
    mode => 775,
    
  }
  
  class { 'nodejs':
    require => Exec['apt-get update']
  }
    
  package { 'supervisor' :
    ensure => present,
    provider => 'npm',
    require => Package['nodejs'],
  }
  
  package { 'coffee-script' :
    ensure => present,
    provider => 'npm',
    require => Package['nodejs'],
  }
  
}
