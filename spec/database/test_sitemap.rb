require 'spec_helper'
module Polygon
  describe Database, "entries" do

    let(:connection){ Polygon.connection(fixtures_path) }

    subject{ connection.query{ sitemap } }

    it 'returns a Relation' do
      subject.should be_a(Relation)
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
