require 'spec_helper'

describe yumrepo('elasticsearch') do
  it { should exist }
  it { should be_enabled }
end

%w{
elasticsearch
}.each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

describe service('elasticsearch') do
  it { should be_enabled }
  it { should be_running }
end

describe "check fluent gem" do
  describe package("gcc") do
    it { should be_installed }
  end
  describe package("libcurl-devel") do
    it { should be_installed }
  end
  describe command("/usr/lib64/fluent/ruby/bin/fluent-gem list --local") do
    its(:content){ should match /fluent-plugin-elasticsearch/ }
  end
end



