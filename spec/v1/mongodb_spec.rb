require 'spec_helper'

describe yumrepo('mongodb') do
  it { should exist }
  it { should be_enabled }
end

%w{
mongodb-org
mongodb-org-mongos
mongodb-org-server
mongodb-org-shell
mongodb-org-tools
}.each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

describe service('mongod') do
  it { should be_enabled }
  it { should be_running }
end
