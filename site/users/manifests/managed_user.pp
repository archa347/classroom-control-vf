define user::managed_user (
  $username = $title,
  $home_dir = "/home/${title}",
  $gid      = $title,
  $groups   = [],
  $ssh_dir  = "${home_dir}/.ssh"
) {
  user { $username : 
    ensure => present,
    group  => $group,
    home   => $home_dir
  }

  File {
    ensure => present,
    owner  => $username,
    mode   => '0700',
  }

  file { [$home_dir,$ssh_dir]:
    ensure => directory,
  }
}
