$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'polygon'

module Helpers

  def fixtures_path
    Path.dir / "fixtures"
  end

end

RSpec.configure do |c|
  c.include Helpers
end