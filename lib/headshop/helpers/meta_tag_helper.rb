module Headshop::Helpers::MetaTagHelper
  def self.included(klass)
    klass.extend ClassMethods
  end
  
  module ClassMethods
    def meta_tag
      write_meta_data(get_meta_data_for(controller.name, controller.action_name))
    end
    
    def get_meta_data_for(controller, action)
      Headshop.meta_data['default_meta']
    end
    
    def write_meta_data meta_data
      meta_array = []
      meta_data.each do |key, value|
        meta_array.push("<meta name='#{key}' content='#{value}' />")
      end
      meta_array.join("\n")
    end
  end
end