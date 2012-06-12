require 'spec_helper'
module Polygon
  describe Entry, 'extensions' do

    let(:entry){ Entry.new(Path.dir, Path.here % Path.dir, options) }

    subject{ entry.extensions }

    before do
      subject.should be_a(Array)
      subject.all?{|e| e.should be_a(String) }
    end

    context 'with default options' do
      let(:options){ {} }
      it 'should contain expected extensions' do
        subject.should eq(['yml', 'md'])
      end
    end

    context 'with explicit options' do
      let(:options){ {:extensions => ["yml", "rb"]} }
      it 'should contain expected extensions' do
        subject.should eq(['yml', 'rb'])
      end
    end

  end
end