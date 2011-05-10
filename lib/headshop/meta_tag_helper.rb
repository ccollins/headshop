module Headshop::MetaTagHelper
  def meta_tag
    write_meta_data(get_meta_data_for(controller_name, action_name))
  end
  
  def get_meta_data_for(controller, action)
    if Headshop.has_meta_data_for?(controller, action) 
      Headshop.meta_data[controller][action] 
    elsif Headshop.meta_data.has_key?('default_meta')
      Headshop.meta_data['default_meta']
    end
  end
  
  def apply_base_tag(key, meta_data)
    if Headshop.meta_data.has_key?('base_meta') && Headshop.meta_data['base_meta'].has_key?(key)
      "#{Headshop.meta_data['base_meta'][key]} #{meta_data}"
    else
      meta_data
    end
  end
  
  def write_meta_data meta_data
    result = meta_data.reduce('') { |memo, obj| memo += "<meta name='#{obj[0]}' content='#{apply_base_tag(obj[0], obj[1])}' />\n" }
    result += "<title>#{apply_base_tag('title', meta_data['title'])}</title>\n" if meta_data.has_key?('title')
    result.respond_to?(:html_safe) ? result.html_safe : result
  end
end