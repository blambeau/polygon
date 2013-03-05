require 'helper'
describe "/sitemap.xml" do

  before do
    get '/sitemap.xml'
  end

  it 'responds' do
    status.should == 200
    content_type.should =~ %r{application/xml}
  end

  it 'contains some url entries' do
    body.should =~ %r{<url>}
  end

  it 'contains expected urls' do
    urls = []
    body.scan %r{<loc>http://[^\/]+/(.*)</loc>} do |match|
      urls << match.first
    end
    expected = database.query{ sitemap }.project([:path])
    got      = Relation(:path => urls)
    got.should eq(expected)
  end

  database.query{ sitemap }.each do |tuple|
    url = tuple[:path]

    describe url do
      before {
        head(url)
        follow_redirect! if status==302
      }
      specify{ status.should == 200 }
    end
  end

end
