require 'action_view'

module Headshop
  class Railtie < Rails::Railtie
    initializer 'headshop.initialize' do
      ActiveSupport.on_load(:action_view) do
        include Headshop::Helpers::MetaTagHelper
      end
    end
  end
end