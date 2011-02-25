require 'rubygems'
require 'bundler'
Bundler.setup

require 'rspec'

RSpec.configure do |config|
  config.mock_with :rspec
end

require File.join(File.dirname(__FILE__), "..", "lib", "headshop")