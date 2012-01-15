require File.expand_path('../spec_helper', __FILE__)
describe Polygon do

  it "should have a version number" do
    Polygon.const_defined?(:VERSION).should be_true
  end

end
