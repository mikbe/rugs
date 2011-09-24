require 'spec_helper'
require 'psych'

describe RUGS::Client do
  
  let(:client) {RUGS::Client.new}
  let(:server){'jamba'}
  let(:url){'git@juice.com'}
  
  context 'when saving remote server settings' do
    
    it "should remember a server's address" do
      client.remote_add(server, url)

      client.server_list.should include(server)
    end
    
    it "should remember default servers" do
      client.remote_add(server, url, "default")

      client.default_servers.should 
        include({"jamba"=>{:url=>"git@juice.com", :default=>true}})
    end
        
    it "should remember multiple default servers" do
      client.remote_add(server, url, "default")
      client.remote_add('some_server', 'git@server.org', "default")
      
      client.default_servers.should == {
        "jamba"=>{:url=>"git@juice.com", :default=>true}, 
        "some_server"=>{:url=>"git@server.org", :default=>true}
      }
    end
    
    after(:each) {clean_config}
    
  end
  
  context 'when creating repos' do

    let(:repo_name) {temp_file}

    it 'should create a local git repo' do
      client.create repo_name
      Dir.exists?(repo_name).should be_true
    end

    it 'should create a git_hooks directory in the local repo' do
      client.create repo_name
      Dir.exists?("#{repo_name}/git_hooks").should be_true
    end
    
    # add remote info automatically

    it 'should set the default servers automatically' do
      client.create repo_name
      puts `git --git-dir="#{repo_name}/.git" --work-tree="#{repo_name}" remote`
    end
    
    after(:each) {clean_temp}

  end
  
  context 'when setting the default server to use' do

    before(:each){client.remote_add(server, url)}
    # 
    # it 'should remember the specified server' do
    #   client.on(server)
    #   client.default_servers.should include(server => url)
    # end
    
    # 
    # it "should default to the 'origin' server if there is one" do
    #   client.remote_add('origin', 'git@default_server.org')
    #   client.default_server.should == 'git@default_server.org'
    # end
    # 
    # it "should not have a default if there is no 'origin' specified" do
    #   client.default_server.should be_nil
    # end
    # 
    # it "should change the default even if there is an 'origin' server" do
    #   client.remote_add('origin', 'git@default_server.org')
    #   client.on(server)
    #   client.default_server.should == url
    # end
    #
    # after(:each) {clean_config}
    
  end
  
end