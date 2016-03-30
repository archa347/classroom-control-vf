define users::managed_user (
  $username  = $title,
  $home_dir  = "/home/${title}",
  $groupname = $title,
  $groups    = [],
  $ssh_dir   = "/home/${title}/.ssh"
) {
  group { $groupname : 
    ensure => present,
  }

  user { $username : 
    ensure  => present,
    gid     => $groupname,
    groups  => $groups,
    home    => $home_dir,
    require => Group[$groupname],
  }

  File {
    ensure => present,
    owner  => $username,
    group  => $groupname,
    mode   => '0644',
  }

  file { [$home_dir,$ssh_dir]:
    ensure => directory,
  }
}
