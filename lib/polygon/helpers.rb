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

    def lispy(&bl)
      @lispy ||= Alf.lispy(settings.database)
      bl ? @lispy.evaluate(&bl) : @lispy
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

  end # module Helpers
end # module Polygon
