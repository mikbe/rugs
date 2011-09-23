require 'spec_helper'
require 'fileutils'

describe RUGS::Client do
  
  let(:client) {RUGS::Client}
  
  context 'When creating repos' do

    let(:repo_name) {temp_name}

    it 'should create a git repo' do
      client.create repo_name
      Dir.exists?(repo_name).should be_true
    end

    it 'should create a git_hooks directory in the local repo' do
      client.create repo_name
      Dir.exists?("#{repo_name}/git_hooks").should be_true
    end
    
  end
  
  after(:all) {FileUtils.rm_rf TEMP}
  
end