require 'helper'
describe "/" do

  before do
    get '/this/is-not-an-existing-page'
  end

  it 'not respond' do
    status.should == 404
    content_type.should =~ %r{text/html}
    body.should =~ %r{<title>Page Not Found}
  end

end
