require 'spec_helper'
module Polygon
  describe Database, "entries" do

    let(:database){ Database.new fixtures_path }

    subject{ database.entries }

    it 'returns a Alf::Iterator' do
      subject.should be_a(Alf::Iterator)
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
