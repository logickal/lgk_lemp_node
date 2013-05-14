node default {

  class {'git': }

  file { '/usr/local/lib/node_modules':
    ensure => "directory",
    owner => 'vagrant',
    group => 'vagrant',
    
  }
  
  class { 'nodejs':
  }
    
#  package { 'supervisor' :
#    ensure => latest,
#    provider => 'npm',
#    require => [Package['nodejs'], File['/usr/local/lib/node_modules']],
#  }
  
  
  
}
