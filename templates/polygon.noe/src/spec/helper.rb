require 'rspec'

require 'rack/test'
ENV['RACK_ENV'] = 'test'

require 'app'

RSpec.configure do |c|

  def app
    App
  end

  def database
    app.settings.database
  end

  def internal?(link)
    link && !(link =~ /^(https?|ftp|mailto):/) && !(link =~ /ajax.googleapis.com/)
  end

  def status
    last_response.status
  end

  def content_type
    last_response.content_type
  end

  def body
    last_response.body
  end

  c.include Rack::Test::Methods
end
