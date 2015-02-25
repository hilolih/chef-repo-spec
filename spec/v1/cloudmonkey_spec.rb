require 'spec_helper'

describe "check python tools" do
  describe package('python') do
    it { should be_installed }
  end

  describe package('python-setuptools') do
    it { should be_installed }
  end
end

describe "check cloudmonkey via easy_install" do
  describe command("cat /usr/lib/python2.6/site-packages/easy-install.pth| grep cloudmonkey") do
    its(:exit_status){ should eq 0 }
  end
end

