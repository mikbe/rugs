require 'spec_helper'
require 'fileutils'

describe RUGS::Server do
  let(:server) {RUGS::Server.new}
  
  context 'When creating repos' do

  end
  
  after(:all) {FileUtils.rm_rf TEMP}
  
end