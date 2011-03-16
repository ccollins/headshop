module Headshop::Helpers::MetaTagHelper
  def self.included(klass)
    klass.extend ClassMethods
  end
  
  module ClassMethods
    def meta_tag
      write_meta_data(get_meta_data_for(controller.name, controller.action_name))
    end
  end
end