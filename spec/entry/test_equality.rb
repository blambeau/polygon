require 'spec_helper'
module Polygon
  describe Entry, '==' do

    subject{ left == right }

    context 'when the same entries' do
      let(:left) { Entry.new(Path.dir, Path.here % Path.dir) }
      let(:right){ Entry.new(Path.dir, Path.here % Path.dir) }
      it{ should be_true }
    end

    context 'when not the same entries' do
      let(:left) { Entry.new(Path.dir, Path.here % Path.dir) }
      let(:right){ Entry.new(Path.dir, "another one") }
      it{ should be_false }
    end

    context 'when bad comparison' do
      let(:left) { Entry.new(Path.dir, Path.here % Path.dir) }
      let(:right){ 12 }
      it{ should be_false }
    end

  end
end