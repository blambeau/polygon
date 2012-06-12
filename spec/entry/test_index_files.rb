require 'spec_helper'
module Polygon
  describe Entry, 'index_files' do

    let(:entry){ Entry.new(Path.dir, Path.here % Path.dir, options) }

    subject{ entry.index_files }

    before do
      subject.should be_a(Array)
      subject.all?{|e| e.should be_a(String) }
    end

    context 'with default options' do
      let(:options){ {} }
      it 'should contain expected index files' do
        subject.should eq(['index.yml', 'index.md'])
      end
    end

    context 'with explicit options' do
      let(:options){ {:extensions => ["yml", "rb"]} }
      it 'should contain expected index files' do
        subject.should eq(['index.yml', 'index.rb'])
      end
    end

  end
end