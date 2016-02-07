require 'spec_helper'

describe 'metche::define', :type => :define do
  ['Debian'].each do |osfamily|
    let(:facts) {{
      :osfamily => osfamily,
    }}
    let(:pre_condition) { 'include metche' }
    let(:title) { 'metche.conf' }

    context "on #{osfamily}" do
      context 'when source file' do
        let(:params) {{
          :config_file_path   => '/etc/metche.2nd.conf',
          :config_file_source => 'puppet:///modules/metche/common/etc/metche.conf',
        }}

        it do
          is_expected.to contain_file('define_metche.conf').with(
            'ensure'  => 'present',
            'source'  => 'puppet:///modules/metche/common/etc/metche.conf',
            'require' => 'Package[metche]',
          )
        end
      end

      context 'when content string' do
        let(:params) {{
          :config_file_path   => '/etc/metche.3rd.conf',
          :config_file_string => '# THIS FILE IS MANAGED BY PUPPET',
        }}

        it do
          is_expected.to contain_file('define_metche.conf').with(
            'ensure'  => 'present',
            'content' => /THIS FILE IS MANAGED BY PUPPET/,
            'require' => 'Package[metche]',
          )
        end
      end

      context 'when content template' do
        let(:params) {{
          :config_file_path     => '/etc/metche.4th.conf',
          :config_file_template => 'metche/common/etc/metche.conf.erb',
        }}

        it do
          is_expected.to contain_file('define_metche.conf').with(
            'ensure'  => 'present',
            'content' => /THIS FILE IS MANAGED BY PUPPET/,
            'require' => 'Package[metche]',
          )
        end
      end

      context 'when content template (custom)' do
        let(:params) {{
          :config_file_path         => '/etc/metche.5th.conf',
          :config_file_template     => 'metche/common/etc/metche.conf.erb',
          :config_file_options_hash => {
            'key' => 'value',
          },
        }}

        it do
          is_expected.to contain_file('define_metche.conf').with(
            'ensure'  => 'present',
            'content' => /THIS FILE IS MANAGED BY PUPPET/,
            'require' => 'Package[metche]',
          )
        end
      end
    end
  end
end
