module Polygon
  module Database
    include Alf::Viewpoint

    class Adapter < Alf::Adapter

      def self.recognizes?(conn_spec)
        Path.like?(conn_spec) && Path(conn_spec).directory?
      end

      def connection
        Connection.new(Path(conn_spec))
      end

      Adapter.register(:polygon, self)
    end # class Adapter

    class Connection < Alf::Adapter::Connection

      alias :folder :conn_spec

      def default_options
        { :extensions => ["yml", "md"] }
      end

      def knows?(name)
        name == :entries
      end

      # Returns a cog for `name`
      def cog(plan, expr)
        name = expr.name
        raise Alf::NoSuchRelvarError, "Unable to find a file for #{name}" unless knows?(name)
        Entries.new(folder, default_options)
      end

    end # class Connection

    native :entries

    def sitemap
      extend(entries,
             path:    ->{ entry.relative_path.to_url            },
             lastmod: ->{ entry.path.mtime.strftime("%Y-%m-%d") })
    end

    class Entries

      def initialize(root, options)
        @root    = root
        @options = options
      end

      def each
        return to_enum unless block_given?
        extensions = @options[:extensions]
        @root.glob("**/*").each do |file|
          next unless file.file? and extensions.include?(file.ext)
          entry = Entry.new(@root, file % @root)
          yield(:entry => entry)
        end
      end

      def compiler
        nil
      end

      def to_relation
        Relation(each.to_a)
      end

    end # class Entries

  end # module Database
end # class Polygon
