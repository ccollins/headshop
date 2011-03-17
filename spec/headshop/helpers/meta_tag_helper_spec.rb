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
    before(:each) do
      controller = Class.new
      @class.stub!(:controller).and_return(controller)
      controller.stub!(:name).and_return('controller')
      controller.stub!(:action_name).and_return('action')
    end
    
    it "should call for and write the meta data" do
      @class.should_receive(:get_meta_data_for).with('controller', 'action').and_return('yippe')
      @class.should_receive(:write_meta_data).with('yippe')
      @class.meta_tag
    end
    
    it "should write the meta data for controller/action" do
      meta_data = @class.meta_tag
      /<meta name='title' content='action_title' \/>\n/.should =~ meta_data
      /<meta name='description' content='action_description' \/>\n/.should =~ meta_data
      /<meta name='keywords' content='action_keywords' \/>\n/.should =~ meta_data
    end
  end
  
  context "#get_meta_data_for" do
    it "should return default data when a controller and action arent found" do
      Headshop.stub!(:has_meta_data_for).and_return(false)
      @class.get_meta_data_for('no_controller', 'no_action').should == {"title"=>"default_title", "description"=>"default_description", "keywords"=>"default_keywords"}
    end
    
    it "should return default data when a controller isnt found" do
      Headshop.stub!(:has_meta_data_for).and_return(false)
      @class.get_meta_data_for('no_controller', 'action').should == {"title"=>"default_title", "description"=>"default_description", "keywords"=>"default_keywords"}
    end
    
    it "should return meta data for a controller and action" do
      Headshop.stub!(:has_meta_data_for).and_return(true)
      @class.get_meta_data_for('controller', 'action').should == {"title"=>"action_title", "description"=>"action_description", "keywords"=>"action_keywords"}
    end
  end
  
  context "#write_meta_data" do
    it "should write meta data for anything" do
      meta_data = @class.write_meta_data({"title"=>"default_title", "description"=>"default_description", "keywords"=>"default_keywords", :yousocrazy => :tester})
      /<meta name='title' content='default_title' \/>\n/.should =~ meta_data
      /<meta name='description' content='default_description' \/>\n/.should =~ meta_data
      /<meta name='keywords' content='default_keywords' \/>\n/.should =~ meta_data
      /<meta name='yousocrazy' content='tester' \/>\n/.should =~ meta_data
    end
  end
end