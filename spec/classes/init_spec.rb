require 'spec_helper'

describe 'metche', :type => :class do
  ['Debian'].each do |osfamily|
    let(:facts) {{
      :osfamily => osfamily,
    }}

    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_anchor('metche::begin') }
    it { is_expected.to contain_class('metche::params') }
    it { is_expected.to contain_class('metche::install') }
    it { is_expected.to contain_class('metche::config') }
    it { is_expected.to contain_anchor('metche::end') }

    context "on #{osfamily}" do
      describe 'metche::install' do
        context 'defaults' do
          it do
            is_expected.to contain_package('metche').with(
              'ensure' => 'present',
            )
            is_expected.to contain_package('apt-show-versions').with(
              'ensure' => 'present',
            )
          end
        end

        context 'when package latest' do
          let(:params) {{
            :package_ensure => 'latest',
          }}

          it do
            is_expected.to contain_package('metche').with(
              'ensure' => 'latest',
            )
            is_expected.to contain_package('apt-show-versions').with(
              'ensure' => 'latest',
            )
          end
        end

        context 'when package absent' do
          let(:params) {{
            :package_ensure => 'absent',
          }}

          it do
            is_expected.to contain_package('metche').with(
              'ensure' => 'absent',
            )
            is_expected.to contain_package('apt-show-versions').with(
              'ensure' => 'absent',
            )
          end
          it do
            is_expected.to contain_file('metche.conf').with(
              'ensure'  => 'present',
              'require' => 'Package[metche]',
            )
          end
        end

        context 'when package purged' do
          let(:params) {{
            :package_ensure => 'purged',
          }}

          it do
            is_expected.to contain_package('metche').with(
              'ensure' => 'purged',
            )
            is_expected.to contain_package('apt-show-versions').with(
              'ensure' => 'purged',
            )
          end
          it do
            is_expected.to contain_file('metche.conf').with(
              'ensure'  => 'absent',
              'require' => 'Package[metche]',
            )
          end
        end
      end

      describe 'metche::config' do
        context 'defaults' do
          it do
            is_expected.to contain_file('metche.conf').with(
              'ensure'  => 'present',
              'require' => 'Package[metche]',
            )
          end
        end

        context 'when source dir' do
          let(:params) {{
            :config_dir_source => 'puppet:///modules/metche/common/etc',
          }}

          it do
            is_expected.to contain_file('metche.dir').with(
              'ensure'  => 'directory',
              'force'   => false,
              'purge'   => false,
              'recurse' => true,
              'source'  => 'puppet:///modules/metche/common/etc',
              'require' => 'Package[metche]',
            )
          end
        end

        context 'when source dir purged' do
          let(:params) {{
            :config_dir_purge  => true,
            :config_dir_source => 'puppet:///modules/metche/common/etc',
          }}

          it do
            is_expected.to contain_file('metche.dir').with(
              'ensure'  => 'directory',
              'force'   => true,
              'purge'   => true,
              'recurse' => true,
              'source'  => 'puppet:///modules/metche/common/etc',
              'require' => 'Package[metche]',
            )
          end
        end

        context 'when source file' do
          let(:params) {{
            :config_file_source => 'puppet:///modules/metche/common/etc/metche.conf',
          }}

          it do
            is_expected.to contain_file('metche.conf').with(
              'ensure'  => 'present',
              'source'  => 'puppet:///modules/metche/common/etc/metche.conf',
              'require' => 'Package[metche]',
            )
          end
        end

        context 'when content string' do
          let(:params) {{
            :config_file_string => '# THIS FILE IS MANAGED BY PUPPET',
          }}

          it do
            is_expected.to contain_file('metche.conf').with(
              'ensure'  => 'present',
              'content' => /THIS FILE IS MANAGED BY PUPPET/,
              'require' => 'Package[metche]',
            )
          end
        end

        context 'when content template' do
          let(:params) {{
            :config_file_template => 'metche/common/etc/metche.conf.erb',
          }}

          it do
            is_expected.to contain_file('metche.conf').with(
              'ensure'  => 'present',
              'content' => /THIS FILE IS MANAGED BY PUPPET/,
              'require' => 'Package[metche]',
            )
          end
        end

        context 'when content template (custom)' do
          let(:params) {{
            :config_file_template     => 'metche/common/etc/metche.conf.erb',
            :config_file_options_hash => {
              'key' => 'value',
            },
          }}

          it do
            is_expected.to contain_file('metche.conf').with(
              'ensure'  => 'present',
              'content' => /THIS FILE IS MANAGED BY PUPPET/,
              'require' => 'Package[metche]',
            )
          end
        end
      end
    end
  end
end
