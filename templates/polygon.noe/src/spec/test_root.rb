require 'helper'
describe "/" do

  before do
    get '/'
  end

  it 'respond' do
    status.should == 200
    content_type.should =~ %r{text/html}
  end

end