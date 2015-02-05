require 'spec_helper'

MYHOME = "/home/vagrant"
ME     = "vagrant"

describe package('libffi-devel') do
  it { should be_installed }
end

describe command('source /etc/profile.d/rbenv.sh; which rbenv') do
  let(:disable_sudo) { true }
  its(:stdout) { should match %r{#{MYHOME}/.rbenv/bin/rbenv} }
end

describe file('/etc/profile.d/rbenv.sh') do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 644 }
  its(:content) { should match(/^export RBENV_ROOT="\${HOME}\/\.rbenv"$/) }
  its(:content) { should match(/^export PATH="\${RBENV_ROOT}\/bin:\${PATH}"$/) }
  its(:content) { should match(/^eval "\$\(rbenv init --no-rehash -\)"$/) }
end

describe file("#{MYHOME}/.rbenv/plugins") do
  it { should be_directory }
  it { should be_owned_by ME }
  it { should be_grouped_into ME }
  it { should be_mode 755 }
end

describe file("#{MYHOME}/.rbenv/plugins/ruby-build") do
  it { should be_directory }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 755 }
end

%w(2.2.0).each do |version|
  describe command("source /etc/profile.d/rbenv.sh; rbenv versions | grep #{version}") do
    let(:disable_sudo) { true }
    its(:stdout) { should match(/#{Regexp.escape(version)}/) }
  end
end

describe command('source /etc/profile.d/rbenv.sh; rbenv global') do
  let(:disable_sudo) { true }
  its(:stdout) { should match(/2.2.0/) }
end

