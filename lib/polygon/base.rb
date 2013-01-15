module Polygon
  class Base < Sinatra::Base

    configure do
      set :public_folder, Proc.new { 'content/static'  }
      set :views,         Proc.new { 'design/views'    }
      set :doc_folder,    Proc.new { 'content/dynamic' }
      set :wlang,         :layout => :"layouts/html5"
      enable  :logging
      enable  :raise_errors
      disable :show_exceptions
    end

    not_found do
      send_file settings.public_folder + '/404.html', :status => 404
    end

    error do
      send_file settings.public_folder + '/500.html', :status => 500
    end

    helpers Polygon::Helpers
  end # Base
end # module Polygon
