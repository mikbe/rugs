require 'spec_helper'
require 'fileutils'

describe RUGS::Git do

  let(:git_server) {"#{TEMP}/git_server"}
  let(:git) {RUGS::Git}
  
  before(:all) do 
    FileUtils.mkdir_p git_server
  end
  
  it 'should initialize a local repository' do
    repo_name = temp_file
    git.init(repo_name).should include("Initialized empty Git repository")
  end
  
  after(:all) {FileUtils.rm_rf TEMP}
  
end