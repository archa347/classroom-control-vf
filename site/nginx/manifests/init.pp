class nginx (
      $package_name=$nginx::params::package_name,
      $nginx_user=$nginx::params::nginx_user,
      $config=$nginx::params::config,
      $server_block=$nginx::params::server_block,
      $docroot,
      $log=$nginx::params::log,
      $file_source=$nginx::params::file_source,
) inherits nginx::params {
  case $::osfamily {
    'redhat','debian': {
      File {
        ensure => present,
        owner  => 'root',
        mode   => '0664',
      }
    }
    'windows' : {
      File {
        ensure => present,
        owner  => 'Administrator',
        mode   => '0664',
      }
    }
  }
  $root= $docroot
  $error_log= "${log}/error.log"
  $nginx_conf= "${config}/nginx.conf"
  $default_conf= "${server_block}/default.conf"
  $index="${root}/index.html"

  package { 'nginx':
    name   => $package_name,
    ensure => present,
  }
  file { $nginx_conf:
    content => template('nginx/nginx.conf.erb'),
    require => Package['nginx'],
  }
  file { $default_conf:
    content => template('nginx/default.conf.erb'),
    require => Package['nginx'],
  }
  file { $root:
    ensure => directory,
  }
  file { $index:
    source  => "${file_source}/index.html",
    require => [Package['nginx'],File[$root]],
  }
  service { 'nginx':
    ensure    => running,
    enable    => true,
    subscribe => [File[$nginx_conf],File[$default_conf]],
  }
}
