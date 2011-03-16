require 'spec_helper'

describe Headshop::Helpers::MetaTagHelper do
  before(:each) do
    Headshop.setup do |config|
      config.config_file = File.join(File.dirname(__FILE__), '..', '..', 'headshop.yml')
    end
      
    @class = Class.new
    @class.send(:include, Headshop::Helpers::MetaTagHelper)
  end
  
  subject { @class }
  it { should respond_to(:meta_tag) }
  
  context "#meta_tag" do
    it "should call for and write the meta data" do
      controller = Class.new
      @class.stub!(:controller).and_return(controller)
      controller.stub!(:name).and_return('controller')
      controller.stub!(:action_name).and_return('action')
      @class.should_receive(:get_meta_data_for).with('controller', 'action').and_return('yippe')
      @class.should_receive(:write_meta_data).with('yippe')
      @class.meta_tag
    end
    
    it "should return the corresponding meta data" do
    end
  end
end