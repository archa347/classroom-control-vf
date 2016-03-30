class users::admins {
  Users::Managed_user { 
    groups => ['admins']
  }

  group { 'admins':
    ensure => present,
  }

  users::managed_user { ['jose','alice','chen'] : 
    require => Group['admins']
  }
}
