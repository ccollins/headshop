require 'spec_helper'

describe Headshop::Helpers::MetaTagHelper do
  before(:all) do
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
  end
  
  context "#get_meta_data_for" do
    it "should return default data without a mapping" do
      @class.get_meta_data_for('controller', 'action').should == {"title"=>"default_title", "description"=>"default_description", "keywords"=>"default_keywords"}
    end
  end
  
  context "#write_meta_data" do
    it "should write meta data for anything" do
      @class.write_meta_data({"title"=>"default_title", "description"=>"default_description", "keywords"=>"default_keywords", :yousocrazy => :tester}).should ==
        "<meta name='title' content='default_title' />\n<meta name='description' content='default_description' />\n<meta name='yousocrazy' content='tester' />\n<meta name='keywords' content='default_keywords' />"
    end
  end
end