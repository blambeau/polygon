module Polygon
  module Helpers

    def static
      settings.static
    end

    def dynamic
      settings.dynamic
    end

    def templates
      settings.templates
    end

    def database
      Polygon.connection(settings.doc_folder)
    end

    def in_production
      settings.environment == :production
    end

    def in_test
      settings.environment == :test
    end

    def in_development
      settings.environment == :development
    end

    def sitemap_locals
      { :urls => database.query{ sitemap } }
    end

    def page_locals(path = "")
      rel = database.relvar{
        unwrap(
          extend(
            restrict(sitemap, path: path),
          data: ->{ entry }),
        :data)
      }
      rel && rel.to_a.first
    end
    alias :index_locals :page_locals

  end # module Helpers
end # module Polygon
