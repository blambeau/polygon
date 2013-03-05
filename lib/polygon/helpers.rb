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
      index_locals.merge(:urls => database.query{ sitemap })
    end

    def normalize_path(path)
      path = path[1..-1] if path =~ /^\//
      path = path[0...-1] if path =~ /\/$/
      path
    end

    def page_locals(path = "")
      path = normalize_path(path)
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
