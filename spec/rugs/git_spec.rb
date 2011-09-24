require 'spec_helper'
require 'fileutils'

describe RUGS::Git do

  let(:git) {RUGS::Git}
  let(:file_name) {random_name}
  let(:repo_path) {"#{Dir.tmpdir}/#{file_name}"}
  
  it 'should initialize a local repository' do
    git.init(repo_path).should include("Initialized empty Git repository")
  end

  it 'should add remote settings to the repo' do
    server    = random_name
    url       = "git@#{random_name}.org"
     
    git.init(repo_path)
    git.remote_add(repo_path, server, url)
    
    remotes = `git --git-dir="#{repo_path}/.git" --work-tree="#{repo_path}" remote`
    remotes.should include(server)

  end
  
  after(:all) {clean_temp}

end