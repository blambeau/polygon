require "polygon/version"
require "polygon/loader"
require "polygon/core_ext"

require 'polygon/entry'
require 'polygon/database'
require 'polygon/helpers'
require 'polygon/base'
require 'polygon/dialect'
#
# A web framework powered by sinatra for mostly static websites
#
module Polygon

  DEFAULT_OPTIONS = { default_viewpoint: Database }

  def self.database(path, options = {})
    options = DEFAULT_OPTIONS.merge(options)
    Alf.database(Database::Adapter.polygon(path), options)
  end

  def self.connection(path, options = {})
    database(path, options).connection
  end

  def self.connect(path, options = {}, &bl)
    database(path, options).connect(&bl)
  end

end # module Polygon
