class profile::wordpress {
  ## Mysql Server
  include '::mysql::server'

  ## Wordpress config

  ## Apache vhost config
  class { 'apache':
    default_vhost => false,
  }

  apache::vhost { 'wordpress.archa347.puppetlabs.vm':
    port    => '80',
    docroot => '/var/www/wordpress',
  }

  ##Local user and group for WP
  group { 'wordpress':
    ensure => present,
  }

  user { 'wordpress':
    ensure  => present,
    gid     => 'wordpress',
    require => Group['wordpress'],
  }


  ##Host Entry

  host { 'wordpress.archa347.puppetlabs.vm':
    ip      => '127.0.0.1',
    target  => '/etc/hosts',
    comment => 'added via wordpress profile',
    ensure  => 'present',
  }
}
