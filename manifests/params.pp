# == Class: metche::params
#
class metche::params {
  $package_name = $::osfamily ? {
    default => 'metche',
  }

  $package_list = $::osfamily ? {
    default => ['apt-show-versions'],
  }

  $config_dir_path = $::osfamily ? {
    default => '/etc',
  }

  $config_file_path = $::osfamily ? {
    default => '/etc/metche.conf',
  }

  $config_file_owner = $::osfamily ? {
    default => 'root',
  }

  $config_file_group = $::osfamily ? {
    default => 'root',
  }

  $config_file_mode = $::osfamily ? {
    default => '0600',
  }

  $config_file_require = $::osfamily ? {
    default => 'Package[metche]',
  }

  case $::osfamily {
    'Debian': {
    }
    default: {
      fail("${::operatingsystem} not supported.")
    }
  }
}
