module Polygon
  module Version

    MAJOR = 0
    MINOR = 0
    TINY  = 3

    def self.to_s
      [ MAJOR, MINOR, TINY ].join('.')
    end

  end
  VERSION = Version.to_s
end
