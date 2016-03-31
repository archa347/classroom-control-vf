class nginx (
  $root='/var/www'
) {
  case $::osfamily {
    'redhat','debian': {
      File {
        ensure => present,
        owner  => 'root',
        mode   => '0664',
      }
      $package_name='nginx'
      $nginx_user= $::osfamily ? {
        'redhat'=> 'nginx',
        'debian'=> 'www-data',
      }
      $config_dir='/etc/nginx/'
      $nginx_conf="${config_dir}nginx.conf"
      $server_block_dir="${config_dir}conf.d/"
      $default_conf="${server_block_dir}default.conf"
      $root_dir=$root
      $index="${root_dir}/index.html"
      $log_dir='/var/log/nginx/'
      $error_log="${log_dir}error.log"
    }
    'windows' : {
      File {
        ensure => present,
        owner  => 'Administrator',
        mode   => '0664',
      }
      $package_name='nginx-service'
      $nginx_user='nobody'
      $config_dir='C:/ProgramData/nginx/'
      $nginx_conf="${config_dir}nginx.conf"
      $server_block_dir="${config_dir}conf.d/"
      $default_conf="${server_block_dir}default.conf"
      $root_dir=$root
      $index="${root_dir}/index.html"
      $log_dir='C:/ProgramData/nginx/logs/'
      $error_log="${log_dir}error.log"
    }
  }

  $file_source='puppet:///modules/nginx'


  package { $package_name:
    ensure => present,
  }
  file { $nginx_conf:
    #source => "${file_source}/nginx.conf",
    content => template('nginx/nginx.conf.erb'),
    require => Package['nginx'],
  }
  file { $default_conf:
    #source  => "${file_source}/default.conf",
    content => template('nginx/default.conf.erb'),
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
