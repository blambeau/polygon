module Polygon
  class Base < Sinatra::Base

    configure do
      set :static,        Proc.new { root && root / 'content/static'  }
      set :public_folder, Proc.new { root && root / 'content/static'  }
      set :dynamic,       Proc.new { root && root / 'content/dynamic' }
      set :views,         Proc.new { root && root / 'design/views'    }
      set :database,      Proc.new { Database.new(dynamic)            }
      enable  :logging
      enable  :raise_errors
      disable :show_exceptions
    end

    helpers Polygon::Helpers
  end # Base
end # module Polygon
