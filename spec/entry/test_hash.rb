require 'spec_helper'
module Polygon
  describe Entry, 'hash' do

    it 'should be consistent with ==' do
      e = Entry.new(Path.dir, Path.here % Path.dir)
      f = Entry.new(Path.dir, Path.here % Path.dir)
      g = Entry.new(Path.dir, 'another one')
      e.hash.should eq(f.hash)
      e.hash.should_not eq(g.hash)
    end

  end
end