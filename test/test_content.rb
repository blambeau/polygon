require 'helper'
module Polygon
  class ContentTest < Test::Unit::TestCase
    include Helper

    def setup
      @root    = Path.dir/"../fixtures"
      @content = Content.new(@root)
    end

    def assert_entry(entry)
      assert_instance_of Content::Entry, entry
    end
    
    def test_initialize
      assert_instance_of Content, Content.new(@root)
    end

    def test_entry_should_be_a_factory
      entry = @content.entry(@root/"index.yml")
      assert_entry entry
      assert_equal @content, entry.content
      assert_equal @root/"index.yml", entry.path
    end

    def test_entry_should_serve_relative_paths
      relative = (@root/"index.yml").relative_to(@root)
      assert_entry @content.entry(relative)
    end
    
    def test_entry_should_serve_valid_absolute_paths
      assert_entry @content.entry(@root/"index.yml")
      assert_entry @content.entry(@root/:data/"data.yml")
    end
    
    def test_entry_should_not_serve_outside_root
      assert_nil @content.entry(Path.home)
      assert_nil @content.entry(@root.parent)
    end

  end
end
