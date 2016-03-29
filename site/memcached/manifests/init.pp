class memcached {
  package { 'memcached':
    ensure => present,
  }

  file { '/etc/sysconfig/memcached':
    ensure  => present,
    source  => 'puppet:///modules/memcached/config',
    require => Package['memcached'],
  }

  servcie { 'memcached':
    ensure    => running,
    subscribe => File['/etc/sysconfig/memcached'],
  }
}

