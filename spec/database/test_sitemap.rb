require 'spec_helper'
module Polygon
  describe Database, "entries" do

    let(:database){ Database.new fixtures_path }

    subject{ database.sitemap }

    it 'returns a Alf::Iterator' do
      subject.should be_a(Alf::Iterator)
    end

    it 'iterates tuples with entries, path and lastmod' do
      subject.each do |tuple|
        tuple.should have_key(:entry)
        tuple[:entry].should be_a(Entry)

        tuple.should have_key(:path)
        tuple[:path].should be_a(String)

        tuple.should have_key(:lastmod)
        tuple[:lastmod].should be_a(String)
      end
    end

  end
end
