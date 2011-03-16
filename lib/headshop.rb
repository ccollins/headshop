require 'headshop/helpers'
require 'headshop/railtie'
require 'yaml'

module Headshop
  mattr_accessor :config_file, :meta_data
  
  def self.config_file= config_file
    @@config_file = config_file
    read_config_file @@config_file
  end
  
  def self.read_config_file config_file
    self.meta_data = YAML.load_file(config_file)
  end
  
  def self.setup
     yield self
  end
end