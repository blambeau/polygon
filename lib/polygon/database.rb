module Polygon
  class Database < Alf::Environment

    attr_reader :root, :options

    def initialize(root, options = {})
      @root    = Path(root)
      @options = default_options.merge(options)
    end

    def default_options
      { :extensions => ["yml", "md"] }
    end

    def dataset(name)
      if name == :entries
        Entries.new(root, options)
      else
        raise Alf::NoSuchDatasetError, "No such dataset `#{name}`"
      end
    end

    def entries
      dataset(:entries)
    end

    def sitemap
      entry2path = Proc.new{ |entry|
        path = entry.relative_path.rm_ext
        path = entry.index? ? path.parent : path
        path = path == Path('.') ? Path("") : path
        path.to_s
      }
      Alf.lispy(self).compile do
        (extend :entries,
                :path    => proc{ entry2path.call(entry)                },
                :lastmod => proc{ entry.path.mtime.strftime("%Y-%m-%d") })
      end
    end

    class Entries
      include Alf::Iterator

      def initialize(root, options)
        @root    = root
        @options = options
      end

      def each
        extensions = @options[:extensions]
        @root.glob("**/*").each do |file|
          next unless file.file? and extensions.include?(file.ext)
          entry = Entry.new(@root, file % @root)
          yield(:entry => entry)
        end
      end

    end # class Entries

  end # class Database
end # class Polygon
