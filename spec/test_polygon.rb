require File.expand_path('../spec_helper', __FILE__)
describe Polygon do

  it "should have a version number" do
    Polygon.const_defined?(:VERSION).should be_true
  end

  def markdown(x)
    x.upcase
  end

  it 'installs a friendly html dialect' do
    tpl = Tilt['wlang'].new{ "~{content}" }
    got = tpl.render(self, :content => "hello world!")
    got.should eq("HELLO WORLD!")
  end

end
