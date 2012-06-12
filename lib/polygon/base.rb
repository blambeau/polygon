module Polygon
  class Base < Sinatra::Base

    configure do
      set :public_folder, Proc.new { 'content/static'                }
      set :views,         Proc.new { 'design/views'                  }
      set :database,      Proc.new { Database.new('content/dynamic') }
      set :wlang,         :layout => :"layouts/html5"
      enable  :logging
      enable  :raise_errors
      disable :show_exceptions
    end

    helpers Polygon::Helpers
  end # Base
end # module Polygon
