$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'polygon'

class Polygon::Entry
  public :extensions, :index_files, :index_file
end

module Helpers

  def fixtures_path
    Path.dir / "fixtures"
  end

end

RSpec.configure do |c|
  c.include Helpers
end