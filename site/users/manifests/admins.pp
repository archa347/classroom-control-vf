class admins {
  Users::Managed_user { 
    groups: ['admins']
  }

  users::managed_user { ['jose','alice','chen'] : }
}
