require 'helper'
describe "/" do

  before do
    get '/'
  end

  it 'responds' do
    status.should == 200
  end

  it 'contains the expected title' do
    body.should =~ %r{<title>${title}</title>}
  end

end
