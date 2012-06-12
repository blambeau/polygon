require 'spec_helper'
module Polygon
  describe Entry, 'exist?' do

    subject{ entry.exist? }

    context 'when it exists' do
      let(:entry){ Entry.new(Path.dir, Path.here % Path.dir) }
      it{ should be_true }
    end

    context 'when it does not exists' do
      let(:entry){ Entry.new(Path.dir, "nosuchone.md") }
      it{ should be_false }
    end

  end
end