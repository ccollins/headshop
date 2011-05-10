module Headshop::MetaTagHelper
  def meta_tag
    write_meta_data(get_meta_data_for(controller_name, action_name))
  end
  
  def get_meta_data_for(controller, action)
    Headshop.has_meta_data_for?(controller, action) ? Headshop.meta_data['controller']['action'] : Headshop.meta_data['default_meta']
  end
  
  def write_meta_data meta_data
    meta_data.reduce('') { |memo, obj| memo += "<meta name='#{obj[0]}' content='#{obj[1]}' />\n" }
  end
end