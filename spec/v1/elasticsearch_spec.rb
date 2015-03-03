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
