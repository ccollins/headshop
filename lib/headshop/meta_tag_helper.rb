require 'action_view'

module Headshop::MetaTagHelper
  include ActionView::Helpers::TagHelper
  
  def meta_tag
    write_meta_data(get_meta_data_for(controller_path, action_name))
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
    display_meta = meta_data.collect { |meta| tag(:meta, {:name => meta[0], :content => apply_base_tag(meta[0], meta[1])}, false, false) }
    display_meta.push(content_tag(:title, apply_base_tag('title', meta_data['title']), nil, false)) if meta_data.has_key?('title')
    display_meta.join("\n").html_safe
  end
end