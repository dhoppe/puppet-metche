# == Class: metche::config
#
class metche::config {
  if $::metche::config_dir_source {
    file { 'metche.dir':
      ensure  => $::metche::config_dir_ensure,
      path    => $::metche::config_dir_path,
      force   => $::metche::config_dir_purge,
      purge   => $::metche::config_dir_purge,
      recurse => $::metche::config_dir_recurse,
      source  => $::metche::config_dir_source,
      require => $::metche::config_file_require,
    }
  }

  if $::metche::config_file_path {
    file { 'metche.conf':
      ensure  => $::metche::config_file_ensure,
      path    => $::metche::config_file_path,
      owner   => $::metche::config_file_owner,
      group   => $::metche::config_file_group,
      mode    => $::metche::config_file_mode,
      source  => $::metche::config_file_source,
      content => $::metche::config_file_content,
      require => $::metche::config_file_require,
    }
  }
}
