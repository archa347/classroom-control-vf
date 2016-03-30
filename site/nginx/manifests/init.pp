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
  $file_source='puppet:///modules/nginx'


  package { 'nginx':
    ensure => present,
  }
  file { $nginx_conf:
    source  => "${file_source}/nginx.conf",
    require => Package['nginx'],
  }
  file { $default_conf:
    source  => "${file_source}/default.conf",
    require => Package['nginx'],
  }
  file { $root_dir:
    ensure => directory,
  }
  file { $index:
    source  => "${file_source}/index.html",
    require => [Package['nginx'],File[$root_dir]],
  }
  service { 'nginx':
    ensure    => running,
    enable    => true,
    subscribe => [File[$nginx_conf],File[$default_conf]],
  }
}
