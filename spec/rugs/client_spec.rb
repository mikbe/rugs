require 'spec_helper'
require 'psych'

describe RUGS::Client do
  
  let(:client) {RUGS::Client.new}

  let(:remote){'test'}
  let(:url){'root@git-test'}
  let(:path){'/srv/repos/git'}
  let(:repo_name){random_name}
  let(:local_repo){"#{TEMP_DIR}/#{repo_name}"}
  
  let(:test_hash){
    {"test"=>{:url=>url, path: nil, :default=>true}}
  }
  let(:another_hash){
    {"another"=>{:url=>"git@another_server.org", path: nil, :default=>true}}
  }
  
  context 'when managing remote server settings' do

    context "and adding or removing servers" do
    
      it "should remember remote servers" do
        client.remote_add(remote, url)

        client.remote_list.should include(remote)
      end
    
      it "should forget remote servers" do
        client.remote_add(remote, url)

        client.remote_remove(remote)
        client.remote_list.should be_empty
      end
    
    end
    
    context "and configuring defaults" do
      
      it "should remember default remotes" do
        client.remote_add(remote, url, "default")

        client.default_remotes.should include(test_hash)
      end
        
      it "should remember multiple default remote" do
        client.remote_add(remote, url, "default")
        client.remote_add('another', 'git@another_server.org', "default")
      
        client.default_remotes.should == {}.merge(test_hash).merge(another_hash)
      end

      it "should set an exisiting remote as a default" do
        client.remote_add(remote, url)
        client.default(remote)
        client.default_remotes.should include(remote)
      end
    
      it "should un-default a remote" do
        client.remote_add(remote, url, "default")
        client.undefault(remote)
        client.default_remotes.should_not include(remote)
      end
    
    end
  
    context "and setting a path to the git repo" do
      
      it "should save the remote path if one is given" do
        client.remote_add(remote, "#{url}:#{path}")
        client.remote_list[remote][:path].should == path
      end
            
      it "should not save a remote path if none is given" do
        client.remote_add(remote, url)
        client.remote_list[remote][:path].should be_nil
      end

    end
    
  end
  
  context 'when creating local repos' do

    it 'should create a local git repo' do
      client.create local_repo
      Dir.exists?(local_repo).should be_true
    end

    it 'should set the default remotes automatically' do
      client.remote_add(remote, url, "default")
      client.remote_add('some_remote', 'git@server.org', "default")
      client.create local_repo

      remotes = `git --git-dir="#{local_repo}/.git" --work-tree="#{local_repo}" remote`
      remotes.should include("test", "some_remote")
    end

    it "should not set default remotes if there aren't any" do
      client.remote_add(remote, url)
      client.remote_add('some_remote', 'git@server.org') 
      client.create local_repo
      puts "local_repo: #{local_repo}"
      remotes = `git --git-dir="#{repo_name}/.git" --work-tree="#{repo_name}" remote`
      remotes.should be_empty
    end

  end

  # It's probably best to set up a git server on a virtual machine for these tests.
  # These tests are set up with the following system in place...
  #
  # You can download a free, ready to run vm from here:
  #  http://www.turnkeylinux.org/revision-control
  #
  # And you can use the free VirtualBox software to run it:
  #  http://www.virtualbox.org/wiki/Downloads
  #
  # You'll also want to set ssh to login without a password, see:
  #  http://mikbe.tk/2010/09/08/login-to-ssh-without-a-password-easily/
  #
  context 'when creating remote repos' do
    
    it 'should create a remote repo' do
      client.remote_add(remote, "#{url}:#{path}")
      
      client.create local_repo, remote
      
      test = `ssh #{url} ls #{path}/#{repo_name}_x.git`
      puts test.inspect
      test.should_not include("No such file")
      
    end

  end

  context "mit der hooks" do

    # it 'should create a git_hooks directory in the local repo' do
    #   client.create repo_name
    #   Dir.exists?("#{repo_name}/git_hooks").should be_true
    # end

  end
  
  after(:each) do
    clean_config
    clean_temp
  end

end