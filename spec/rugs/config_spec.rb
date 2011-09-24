require 'spec_helper'
require 'psych'

describe RUGS::Client do
  
  let(:config) {RUGS::Config}
  let(:file_name){random_name}
  let(:config_file){"#{config::PATH}/#{file_name}.yaml"}
  let(:data){{some_key: 'some data'}}

  context 'when saving remote server settings' do

    it "should create a config file" do
      config.save(file_name, data)

      File.exist?(config_file).should be_true
    end

    it "should save the server's address in the config file" do
      config.save(file_name, data)

      servers = Psych.load(File.open(config_file))
      servers.should include(data)
    end
    
    it "should load saved data" do
      config.save(file_name, data)
      
      config.load(file_name).should == data
    end
    
  end

end