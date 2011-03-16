require 'spec_helper'

describe Headshop do
  let(:config_file) { 'headshop.yml' }
  
  it { should respond_to(:setup) }
  it { should respond_to(:config_file=) }
  it { should respond_to(:config_file) }
  it { should respond_to(:meta_data) }
  
  context "#config_file=" do
    before(:each) do
      Headshop.should_receive(:read_config_file).and_return('')
    end
    
    it "should set the file path and read it in" do
      Headshop.setup do |config|
        config.config_file = 'shamalamadingdong'
      end
      Headshop.config_file.should == 'shamalamadingdong'
    end
  end
  
  context "#read_config_file" do
    it "should read and parse the yaml file" do
      YAML.should_receive(:load_file).with(config_file).and_return({:test => 'test'})
      Headshop.read_config_file(config_file)
      Headshop.meta_data.should == {:test => 'test'}
    end
  end
end