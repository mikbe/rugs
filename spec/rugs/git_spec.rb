require 'spec_helper'
require 'fileutils'

describe RUGS::Git do

  let(:git) {RUGS::Git}
    
  it 'should run commands git knows' do
    repo_name = temp_name
    git.init(repo_name).should include("Initialized empty Git repository")
  end
  
  it 'should not run commands git does not know' do
    repo_name = temp_name
    expect{git.unicorn_and_rainbows(repo_name)}.should 
      raise_error(Object::Exception)
  end
  
  after(:all) {FileUtils.rm_rf TEMP}
  
end