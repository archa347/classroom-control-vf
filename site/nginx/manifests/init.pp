class nginx {
  File {
    ensure => present,
    owner  => 'root',
    mode   => '0664',
  }

  $nginx_conf='/etc/nginx/nginx.conf'
  $default_conf='/etc/nginx/conf.d/default.conf'
  $root_dir='/var/www'
  $index="${root_dir}/index.html"

  package { 'nginx':
    ensure => present,
  }
  file { $nginx_conf:
    source  => 'puppet:///modules/nginx/nginx.conf',
    require => Package['nginx'],
  }
  file { $default_conf:
    source  => 'puppet:///modules/nginx/default.conf',
    require => Package['nginx'],
  }
  file { $root_dir:
    ensure => directory,
  }
  file { $index:
    source  => 'puppet:///modules/nginx/index.html',
    require => [Package['nginx'],File['/var/www']],
  }
  service { 'nginx':
    ensure    => running,
    enable    => true,
    subscribe => [File[$nginx_conf],File[$default_conf]],
  }
}
