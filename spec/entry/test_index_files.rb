require 'spec_helper'
module Polygon
  describe Entry, 'index_files' do

    subject{ Entry.index_files }

    it 'should be an array of file names' do
      subject.should be_a(Array)
      subject.all?{|e| e.should be_a(String) }
    end

    it 'should contain expected index files' do
      subject.should include('index.yml', 'index.rb', 'index.md')
    end

  end
end