require 'spec_helper'

describe Headshop::MetaTagHelper do
  before(:each) do
    Headshop.setup do |config|
      config.config_file = File.join(File.dirname(__FILE__), '..', '..', 'headshop.yml')
    end
      
    Class.send(:include, Headshop::MetaTagHelper)
  end
  
  it { Class.should respond_to(:meta_tag) }
  
  context "#apply_base_tag" do
    it "should prepend the base tag" do
      Headshop.meta_data['base_meta'] = {'test' => 'base |'}
      Class.apply_base_tag('test', "default_test").should == "base | default_test"
    end
    
    it "should return the tag if no base match found" do
      Class.apply_base_tag('test', "default_test").should == "default_test"
    end
  end
  
  context "#meta_tag" do
    before(:each) do
      Class.stub!(:controller_path).and_return('controller')
      Class.stub!(:action_name).and_return('action')
    end
    
    it "should call for and write the meta data" do
      Class.should_receive(:get_meta_data_for).with('controller', 'action').and_return('yippe')
      Class.should_receive(:write_meta_data).with('yippe')
      Class.meta_tag
    end
    
    it "should write the meta data for controller/action with no base/default" do
      Headshop.setup do |config|
        config.config_file = File.join(File.dirname(__FILE__), '..', '..', 'headshop_no_default_no_base.yml')
      end
    
      meta_data = Class.meta_tag
      /<title>action_title<\/title>/.should =~ meta_data
      /<meta content="action_title" name="title" \/>/.should =~ meta_data
      /<meta content="action_description" name="description" \/>/.should =~ meta_data
      /<meta content="action_keywords" name="keywords" \/>/.should =~ meta_data
    end
    
    it "should write the meta data for controller/action" do
      meta_data = Class.meta_tag
      /<title>base | action_title<\/title>/.should =~ meta_data
      /<meta content="base | action_title" name="title" \/>/.should =~ meta_data
      /<meta content="base | action_description" name="description" \/>/.should =~ meta_data
      /<meta content="base, action_keywords" name="keywords" \/>/.should =~ meta_data
    end
  end
  
  context "#get_meta_data_for" do
    it "should return default data when a controller and action arent found" do
      Class.get_meta_data_for('no_controller', 'no_action').should == {"title"=>"default_title", "description"=>"default_description", "keywords"=>"default_keywords"}
    end
    
    it "should return default data when a controller isnt found" do
      Class.get_meta_data_for('no_controller', 'action').should == {"title"=>"default_title", "description"=>"default_description", "keywords"=>"default_keywords"}
    end
    
    it "should return meta data for a controller and action" do
      Class.get_meta_data_for('controller', 'action').should == {"title"=>"action_title", "description"=>"action_description", "keywords"=>"action_keywords"}
    end
    
    it "should return nil when a controller and action arent found and no default set" do
      Headshop.setup do |config|
        config.config_file = File.join(File.dirname(__FILE__), '..', '..', 'headshop_no_default_no_base.yml')
      end
      
      Class.get_meta_data_for('no_controller', 'no_action').should be_nil
    end
  end
  
  context "#write_meta_data" do
    it "should write meta data for anything" do
      meta_data = Class.write_meta_data({:yousocrazy => :tester})
      /<meta content="tester" name="yousocrazy" \/>/.should =~ meta_data
    end
  end
end