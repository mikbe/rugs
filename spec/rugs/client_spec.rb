require 'spec_helper'
require 'psych'

describe RUGS::Client do
  
  let(:client) {RUGS::Client.new}
  let(:remote){'jamba'}
  let(:url){'git@juice.com'}
  
  context 'when managing remote server settings' do
    
    let(:repo_name) {temp_file}

    it "should remember remote servers" do
      client.remote_add(remote, url)

      client.remote_list.should include(remote)
    end
    
    it "should forget remote servers" do
      client.remote_add(remote, url)

      client.remote_remove(remote)
      client.remote_list.should be_empty
    end
    
    it "should remember default remotes" do
      client.remote_add(remote, url, "default")

      client.default_remotes.should 
        include({"jamba"=>{:url=>"git@juice.com", :default=>true}})
    end
        
    it "should remember multiple default remote" do
      client.remote_add(remote, url, "default")
      client.remote_add('some_remote', 'git@server.org', "default")
      
      client.default_remotes.should == {
        "jamba"=>{:url=>"git@juice.com", :default=>true}, 
        "some_remote"=>{:url=>"git@server.org", :default=>true}
      }
    end

    it "should set an non-default to be a default" do
      client.remote_add(remote, url)
      client.default(remote)
      client.default_remotes.should include(remote)
    end
    
    it "should un-default a remote" do
      client.remote_add(remote, url, "default")
      client.undefault(remote)
      client.default_remotes.should_not include(remote)
    end

    after(:each) {clean_config}
    
  end
  
  context 'when creating local repos' do

    let(:repo_name) {temp_file}
    
    it 'should remember the current specified remote' do
      client.remote_add(remote, url)

      client.on(remote)
      client.current_remote.should include(remote)
    end
 
    it 'should create a local git repo' do
      client.create repo_name
      Dir.exists?(repo_name).should be_true
    end

    it 'should create a git_hooks directory in the local repo' do
      client.create repo_name
      Dir.exists?("#{repo_name}/git_hooks").should be_true
    end

    it 'should set the default remotes automatically' do
      client.remote_add(remote, url, "default")
      client.remote_add('some_remote', 'git@server.org', "default")
      client.create repo_name

      remotes = `git --git-dir="#{repo_name}/.git" --work-tree="#{repo_name}" remote`
      remotes.should include("jamba", "some_remote")
    end
        
    it "should not set default remotes if there aren't any" do
      client.remote_add(remote, url)
      client.remote_add('some_remote', 'git@server.org')
      client.create repo_name

      remotes = `git --git-dir="#{repo_name}/.git" --work-tree="#{repo_name}" remote`
      remotes.should be_empty
    end

    after(:each) {clean_temp}

  end
    
end