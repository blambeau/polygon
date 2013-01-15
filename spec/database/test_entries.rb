require 'spec_helper'
module Polygon
  describe Database, "entries" do

    let(:connection){ Polygon.connection(fixtures_path) }

    subject{ connection.query{ entries } }

    it 'should be a Relation' do
      subject.should be_a(Relation)
    end

    it 'iterates tuples with entries' do
      subject.each do |tuple|
        tuple.should have_key(:entry)
        tuple[:entry].should be_a(Entry)
      end
    end

    it 'iterates tuples with entries of different paths' do
      paths = subject.map{|t| t[:entry].relative_path.to_s }.uniq
      paths.size.should eq(subject.to_a.size)
    end

  end
end
