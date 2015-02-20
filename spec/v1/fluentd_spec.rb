require 'spec_helper'

describe "before install fluentd" do
  describe command('ulimit -n') do
    its(:stdout) { should match /65535/ }
  end
  
  describe file('/etc/security/limits.conf') do
    its(:content) { should match /root\s+soft\s+nofile\s+65536/ }
    its(:content) { should match /root\s+hard\s+nofile\s+65536/ }
  end

  describe command('sysctl -p') do
    its(:stdout) { should match /net\.ipv4\.tcp_tw_recycle\s+=\s+1/ }
    its(:stdout) { should match /net\.ipv4\.tcp_tw_reuse\s+=\s+1/ }
    its(:stdout) { should match /net\.ipv4\.ip_local_port_range\s+=\s+10240\s+65535/ }
  end

  describe file('/etc/sysctl.conf') do
    its(:content) { should match /net\.ipv4\.tcp_tw_recycle\s+=\s+1/ }
    its(:content) { should match /net\.ipv4\.tcp_tw_reuse\s+=\s+1/ }
    its(:content) { should match /net\.ipv4\.ip_local_port_range\s+=\s+10240\s+65535/ }
  end
  
end

#  %w{
#  mongodb-org
#  mongodb-org-mongos
#  mongodb-org-server
#  mongodb-org-shell
#  mongodb-org-tools
#  }.each do |pkg|
#    describe package(pkg) do
#      it { should be_installed }
#    end
#  end
#describe service('mongod') do
#  it { should be_enabled }
#  it { should be_running }
#end
#
