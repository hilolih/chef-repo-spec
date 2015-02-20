require 'spec_helper'

describe package("ntp") do
  it { should be_installed }
end

describe service('ntpd') do
  it { should be_enabled }
  it { should be_running }
end

describe file('/etc/ntp.conf') do
  its(:content) { should match /server\s+-4\s+ntp\.nict\.jp/}
  its(:content) { should match /server\s+-4\s+ntp1\.jst\.mfeed\.ad\.jp/}
  its(:content) { should match /server\s+-4\s+ntp2\.jst\.mfeed\.ad\.jp/}
  its(:content) { should match /server\s+-4\s+ntp3\.jst\.mfeed\.ad\.jp/}
end
