class nginx::params { 
  case $::osfamily {
    'redhat','debian': {
      $package_name='nginx'
      $nginx_user= $::osfamily ? {
        'redhat'=> 'nginx',
        'debian'=> 'www-data',
      }
      $config='/etc/nginx'
      $server_block="${config}/conf.d"
      $root='/var/www'
      $log='/var/log/nginx'
    }
    'windows' : {
      $package_name='nginx-service'
      $nginx_user='nobody'
      $config='C:/ProgramData/nginx'
      $server_block="${config}/conf.d"
      $root='C:/ProgramData/nginx/html'
      $log='C:/ProgramData/nginx/logs'
    }
  }
  $file_source='puppet:///modules/nginx'
}
