# == Class: metche::install
#
class metche::install {
  if $::metche::package_name {
    package { 'metche':
      ensure => $::metche::package_ensure,
      name   => $::metche::package_name,
    }
  }

  if $::metche::package_list {
    ensure_resource('package', $::metche::package_list, { 'ensure' => $::metche::package_ensure })
  }
}
