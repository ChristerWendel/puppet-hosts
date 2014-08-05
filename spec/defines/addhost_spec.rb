require 'spec_helper'

describe 'hosts::addhost', :type => :define do
  let(:title) { 'hosts::addhost' }

  context 'with minimal parameters' do
    let(:params) { {
        :ipaddress => '127.0.0.1',
        :hostname => 'localhost'
      }
    }

    it { should contain_augeas('hosts::addhost')
        .with_context('/files/etc/hosts')
        .with_changes(/set 01\/ipaddr 127.0.0.1/)
        .with_changes(/set 01\/canonical localhost/)
        .without_changes(/set 01\/alias/)
    }
  end

  context 'with host alias parameters' do
    let(:params) { {
        :ipaddress => '127.0.0.1',
        :hostname => 'localhost',
        :aliases => ['localhost.lan', 'loopback']
      }
    }

    it { should contain_augeas('hosts::addhost')
        .with_context('/files/etc/hosts')
        .with_changes(/set 01\/ipaddr 127\.0\.0\.1/)
        .with_changes(/set 01\/canonical localhost/)
        .with_changes(/set 01\/alias\[1\] localhost.lan/)
        .with_changes(/set 01\/alias\[2\] loopback/)
    }
  end

  context 'with host alias parameters' do
    let(:params) { {
        :ipaddress => '192.168.0.1',
        :hostname => 'gateway.lan',
      }
    }

    it { should contain_augeas('hosts::addhost')
        .with_context('/files/etc/hosts')
        .with_changes(/set 01\/ipaddr 192\.168\.0\.1/)
        .with_changes(/set 01\/canonical gateway.lan/)
        .without_changes(/set 01\/ipaddr 127\.0\.0\.1/)
        .without_changes(/set 01\/canonical localhost/)
        .without_changes(/set 01\/alias/)
    }
  end
end
