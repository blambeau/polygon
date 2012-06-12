require 'spec_helper'
module Polygon
  describe Entry, 'parent' do

    subject{ entry.parent }

    before do
      subject.should be_a(Entry) unless subject.nil?
    end

    context 'when a normal entry' do
      let(:entry){ Entry.new(Path.dir, Path.here % Path.dir) }
      it "should be the last index file" do
        subject.path.should eq(Path.dir / Entry.index_file(-1))
      end
    end

    context 'when the second index file' do
      let(:entry){ Entry.new(Path.dir, Entry.index_file(1)) }
      it "should be the first index file" do
        subject.path.should eq(Path.dir / Entry.index_file(0))
      end
    end

    context 'when the first index file and not in root' do
      let(:entry){ Entry.new(Path.dir, Path("subfolder") / Entry.index_file(0)) }
      it "should be the last index of the parent" do
        subject.path.should eq(Path.dir / Entry.index_file(-1))
      end
    end

    context 'when the first index file and not in' do
      let(:entry){ Entry.new(Path.dir, Entry.index_file(0)) }
      it "should be nil" do
        subject.should be_nil
      end
    end

  end
end