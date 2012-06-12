require 'spec_helper'
module Polygon
  describe Entry, 'extensions' do

    subject{ Entry.extensions }

    it 'should be an array of extensions' do
      subject.should be_a(Array)
      subject.all?{|e| e.should be_a(String) }
    end

    it 'should contain expected extensions' do
      subject.should include('yml', 'rb', 'md')
    end

  end
end