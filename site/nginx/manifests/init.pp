class nginx {
  package { 'nginx':
    ensure => present,
  }
  file { 'nginx.conf':
    path    => '/etc/nginx/nginx.conf',
    ensure  => present,
    source  => 'puppet:///modules/nginx/nginx.conf',
    require => Package['nginx'],
  }
  file { 'default.conf':
    path    => '/etc/nginx/conf.d/default.conf',
    ensure  => present,
    source  => 'puppet:///modules/nginx/default.conf',
    require => Package['nginx'],
  }
  file { 'index.html':
    path    => '/var/www/index.html',
    ensure  => present,
    source  => 'puppet:///modules/nginx/index.html',
    require => Package['nginx'],
  }
  service { 'nginx':
    ensure    => running,
    enable    => true,
    subscribe => [File['nginx.conf'],File['default.conf']],
  }
}
