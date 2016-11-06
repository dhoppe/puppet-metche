# metche

[![Build Status](https://travis-ci.org/dhoppe/puppet-metche.png?branch=master)](https://travis-ci.org/dhoppe/puppet-metche)
[![Code Coverage](https://coveralls.io/repos/github/dhoppe/puppet-metche/badge.svg?branch=master)](https://coveralls.io/github/dhoppe/puppet-metche)
[![Puppet Forge](https://img.shields.io/puppetforge/v/dhoppe/metche.svg)](https://forge.puppetlabs.com/dhoppe/metche)
[![Puppet Forge - downloads](https://img.shields.io/puppetforge/dt/dhoppe/metche.svg)](https://forge.puppetlabs.com/dhoppe/metche)
[![Puppet Forge - endorsement](https://img.shields.io/puppetforge/e/dhoppe/metche.svg)](https://forge.puppetlabs.com/dhoppe/metche)
[![Puppet Forge - scores](https://img.shields.io/puppetforge/f/dhoppe/metche.svg)](https://forge.puppetlabs.com/dhoppe/metche)

#### Table of Contents

1. [Overview](#overview)
1. [Module Description - What the module does and why it is useful](#module-description)
1. [Setup - The basics of getting started with metche](#setup)
    * [What metche affects](#what-metche-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with metche](#beginning-with-metche)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Overview

This module installs and configures the Metche package.

## Module Description

This module handles installing and configuring Metche across a range of
operating systems and distributions.

## Setup

### What metche affects

* metche package.
* metche configuration file.

### Setup Requirements

* Puppet >= 3.0
* Facter >= 1.6
* [Stdlib module](https://github.com/puppetlabs/puppetlabs-stdlib)

### Beginning with metche

Install metche with the default parameters ***(No configuration files will be changed)***.

```puppet
    class { 'metche': }
```

Install metche with the recommended parameters.

```puppet
    class { 'metche':
      config_file_template => 'metche/common/etc/metche.conf.erb',
      config_file_hash     => {
        'metche' => {
          config_file_path   => '/etc/cron.d/metche',
          config_file_mode   => '0644',
          config_file_source => 'puppet:///modules/metche/common/etc/cron.d/metche',
        },
      },
    }
```

## Usage

Update the metche package.

```puppet
    class { 'metche':
      package_ensure => 'latest',
    }
```

Remove the metche package.

```puppet
    class { 'metche':
      package_ensure => 'absent',
    }
```

Purge the metche package ***(All configuration files will be removed)***.

```puppet
    class { 'metche':
      package_ensure => 'purged',
    }
```

Deploy the configuration files from source directory.

```puppet
    class { 'metche':
      config_dir_source => 'puppet:///modules/metche/common/etc',
    }
```

Deploy the configuration files from source directory ***(Unmanaged configuration
files will be removed)***.

```puppet
    class { 'metche':
      config_dir_purge  => true,
      config_dir_source => 'puppet:///modules/metche/common/etc',
    }
```

Deploy the configuration file from source.

```puppet
    class { 'metche':
      config_file_source => 'puppet:///modules/metche/common/etc/metche.conf',
    }
```

Deploy the configuration file from string.

```puppet
    class { 'metche':
      config_file_string => '# THIS FILE IS MANAGED BY PUPPET',
    }
```

Deploy the configuration file from template.

```puppet
    class { 'metche':
      config_file_template => 'metche/common/etc/metche.conf.erb',
    }
```

Deploy the configuration file from custom template ***(Additional parameters can
be defined)***.

```puppet
    class { 'metche':
      config_file_template     => 'metche/common/etc/metche.conf.erb',
      config_file_options_hash => {
        'key' => 'value',
      },
    }
```

Deploy additional configuration files from source, string or template.

```puppet
    class { 'metche':
      config_file_hash => {
        'metche.2nd.conf' => {
          config_file_path   => '/common/etc/metche.2nd.conf',
          config_file_source => 'puppet:///modules/metche/common/etc/metche.2nd.conf',
        },
        'metche.3rd.conf' => {
          config_file_path   => '/common/etc/metche.3rd.conf',
          config_file_string => '# THIS FILE IS MANAGED BY PUPPET',
        },
        'metche.4th.conf' => {
          config_file_path     => '/common/etc/metche.4th.conf',
          config_file_template => 'metche/common/etc/metche.4th.conf.erb',
        },
      },
    }
```

## Reference

### Classes

#### Public Classes

* metche: Main class, includes all other classes.

#### Private Classes

* metche::install: Handles the packages.
* metche::config: Handles the configuration file.

### Parameters

#### `package_ensure`

Determines if the package should be installed. Valid values are 'present',
'latest', 'absent' and 'purged'. Defaults to 'present'.

#### `package_name`

Determines the name of package to manage. Defaults to 'metche'.

#### `package_list`

Determines if additional packages should be managed. Defaults to '['apt-show-versions']'.

#### `config_dir_ensure`

Determines if the configuration directory should be present. Valid values are
'absent' and 'directory'. Defaults to 'directory'.

#### `config_dir_path`

Determines if the configuration directory should be managed. Defaults to '/etc'

#### `config_dir_purge`

Determines if unmanaged configuration files should be removed. Valid values are
'true' and 'false'. Defaults to 'false'.

#### `config_dir_recurse`

Determines if the configuration directory should be recursively managed. Valid
values are 'true' and 'false'. Defaults to 'true'.

#### `config_dir_source`

Determines the source of a configuration directory. Defaults to 'undef'.

#### `config_file_ensure`

Determines if the configuration file should be present. Valid values are 'absent'
and 'present'. Defaults to 'present'.

#### `config_file_path`

Determines if the configuration file should be managed. Defaults to '/common/etc/metche.conf'

#### `config_file_owner`

Determines which user should own the configuration file. Defaults to 'root'.

#### `config_file_group`

Determines which group should own the configuration file. Defaults to 'root'.

#### `config_file_mode`

Determines the desired permissions mode of the configuration file. Defaults to '0600'.

#### `config_file_source`

Determines the source of a configuration file. Defaults to 'undef'.

#### `config_file_string`

Determines the content of a configuration file. Defaults to 'undef'.

#### `config_file_template`

Determines the content of a configuration file. Defaults to 'undef'.

#### `config_file_require`

Determines which package a configuration file depends on. Defaults to 'Package[metche]'.

#### `config_file_hash`

Determines which configuration files should be managed via `metche::define`.
Defaults to '{}'.

#### `config_file_options_hash`

Determines which parameters should be passed to an ERB template. Defaults to '{}'.

#### `email`

Determines which email address should be notified about config or package changes.
Defaults to "metche@${::domain}".

## Limitations

This module has been tested on:

* Debian 6/7/8
* Ubuntu 12.04/14.04/16.04

## Development

### Bug Report

If you find a bug, have trouble following the documentation or have a question
about this module - please create an issue.

### Pull Request

If you are able to patch the bug or add the feature yourself - please make a
pull request.

### Contributors

The list of contributors can be found at: [https://github.com/dhoppe/puppet-metche/graphs/contributors](https://github.com/dhoppe/puppet-metche/graphs/contributors)
