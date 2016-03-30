define users::managed_user (
  $username = $title,
  $home_dir = "/home/${title}",
  $gid      = $title,
  $groups   = [],
  $ssh_dir  = "/home/${title}/.ssh"
) {
  user { $username : 
    ensure => present,
    groups  => $groups,
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
