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

  it 'should add remote settings to the repo' do
    repo_name = temp_file
    server    = random_name
    url       = "git@#{random_name}.org"
     
    git.init(repo_name)
    git.remote_add(repo_name, server, url)
    
    remotes = `git --git-dir="#{repo_name}/.git" --work-tree="#{repo_name}" remote`
    remotes.should include(server)

  end
  
  after(:all) {FileUtils.rm_rf TEMP}
  
end