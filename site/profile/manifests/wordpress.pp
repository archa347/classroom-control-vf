class profile::wordpress {
  ## Mysql Server

  class { '::mysql::server': }

  ## Wordpress config

  ## Apache vhost config

  ##Local user and group for WP

  ##Host Entry
}
