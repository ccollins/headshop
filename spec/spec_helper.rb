require 'rubygems'
require 'bundler'
Bundler.setup

require 'rspec'
require "action_controller/railtie"

RSpec.configure do |config|
  config.mock_with :rspec
end

require File.join(File.dirname(__FILE__), "..", "lib", "headshop")

#TODO
#apply base tag to all tags
#write out <title></title>