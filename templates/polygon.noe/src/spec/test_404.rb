require 'helper'
describe "/this/is-not-an-existing-page" do

  before do
    get '/this/is-not-an-existing-page'
  end

  it 'does not respond' do
    status.should == 404
    content_type.should =~ %r{text/html}
    body.should =~ %r{<title>Page Not Found}
  end

end
