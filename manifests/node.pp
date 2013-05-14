node default {
  class {'git': }

  include nodejs

  package { 'supervisor' :
    ensure => latest,
    provider => 'npm',
  }
  
}
