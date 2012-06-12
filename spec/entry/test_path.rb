require 'spec_helper'
module Polygon
  describe Entry, 'path' do

    let(:entry){ Entry.new(Path.dir, Path.here % Path.dir) }

    subject{ entry.path }

    it 'is a path instance' do
      subject.should be_a(Path)
    end

    it "is the concatenation of root and relative_path" do
      subject.should eq(entry.root / entry.relative_path)
      subject.should eq(Path.here)
    end

  end
end