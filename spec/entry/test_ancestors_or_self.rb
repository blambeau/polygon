require 'spec_helper'
module Polygon
  describe Entry, 'ancestors_or_self' do

    subject{ entry.ancestors_or_self(filter) }

    context 'when a normal entry in root' do
      let(:filter){ false }
      let(:entry){ Entry.new(Path.dir, Path.here % Path.dir) }
      it "should contain all index files" do
        expected = entry.index_files.map{|index|
          Entry.new(Path.dir, index)
        } + [ entry ]
        subject.should eq(expected)
      end
    end

    context 'when filtered' do
      let(:filter){ true }
      let(:entry){ Entry.new(Path.dir, Path.here % Path.dir) }
      it "should contain only existing files" do
        subject.should eq([ entry ])
      end
    end

    context 'when the root and not filtered' do
      let(:filter){ false }
      let(:entry){ Entry.new(Path.dir, 'index.yml') }
      it "should be the singleton" do
        subject.should eq([entry])
      end
    end

    context 'when the root and filtered' do
      let(:filter){ true }
      let(:entry){ Entry.new(Path.dir, "index.yml") }
      it "should be empty" do
        subject.should eq([])
      end
    end

  end
end