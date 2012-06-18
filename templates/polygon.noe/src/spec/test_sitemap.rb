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
    expected = database.sitemap.to_rel.project([:path])
    got      = Relation(:path => urls)
    pending{ got.should eq(expected) }
  end

  database.sitemap.each do |tuple|
    url = tuple[:path]

    describe url do
      before { head(url)            }
      specify{ status.should == 200 }
    end
  end

end
