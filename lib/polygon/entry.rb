module Polygon
  class Entry

    attr_reader :root, :relative_path

    def initialize(root, relative_path)
      @root, @relative_path = Path(root), Path(relative_path)
    end

    def path
      root / relative_path
    end

    def exist?
      path.exist?
    end

    def index?
      path.basename.rm_ext.to_s == "index"
    end

    def /(path)
      entry = Entry.new(root, self.relative_path / path)
      if entry.path.inside?(root)
        entry
      else
        nil
      end
    end

    def parent
      @parent ||= begin
        return nil unless base = self/".."
        idx = -1
        if index?
          idx = Entry.index_files.index(path.basename.to_s) - 1
          base = base/".." if idx == -1
        end
        base ? base/Entry.index_files[idx] : nil
      end
    end

    def ancestors_or_self(filter_unexisting = false)
      res = _ancestors_or_self
      filter_unexisting ? res.select{|f| f.path.exist?} : res
    end

    def to_hash
      ancestors_or_self(true).inject({}) do |h,entry|
        Entry.merge(h, entry.data)
      end
    end

    def ==(other)
      other.is_a?(Entry) and other.path == path
    end

    def hash
      path.hash
    end

    def self.extensions
      Path::LOADERS.keys
    end

    def self.index_files
      extensions.map{|ext| "index.#{ext}"}
    end

    def self.index_file(i = 0)
      index_files[i]
    end

    def self.merge(left, right)
      raise "Unexpected #{left.class} vs. #{right.class}" \
        unless left.class == right.class
      case left
      when Array
        (right | left).uniq
      when Hash
        left.merge(right){|k,l,r| merge(l,r)}
      else
        right
      end
    end

  protected

    def data
      path.load
    end

    def _ancestors_or_self
      return [ self ] unless parent
      parent.ancestors_or_self + [ self ]
    end

  end # class Entry
end # module Polygon
