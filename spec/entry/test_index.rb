require 'spec_helper'
module Polygon
  describe Entry, 'index?' do

    subject{ entry.index? }

    context 'when an index file' do
      let(:entry){ Entry.new(Path.dir, "index.yml") }
      it{ should be_true }
    end

    context 'when not an index file' do
      let(:entry){ Entry.new(Path.dir, "nosuchone.md") }
      it{ should be_false }
    end

  end
end