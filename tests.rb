require 'rubygems'
require 'rack/test'
require 'minitest/autorun'

APP = Rack::Builder.parse_file('config.ru').first

class FocusstreakTest < Minitest::Test
  include Rack::Test::Methods

  @oauth_secret = nil

  def app
    Focusstreak.set :environment, :test
    MongoMapper.database = MongoMapper.database.name + "_test"

    MongoMapper.database.collections.each do |c|
      c.drop
    end
    APP
  end

  def setup
    if not @oauth_secret
        client = Rack::OAuth2::Server.register(:display_name=>"TestClient",
            :link=>"http://example.com/",
            :image_url=>"http://example.com/logo.jpg",
            :scope=>%{read write},
            :redirect_uri=>"http://example.com/oauth/callback")
        @oauth_secret = client.secret

        post '/oauth/access_token', {:client_secret => client.secret, :client_id => client._id, :grant_type => 'none'}
        @access_token = JSON.parse(last_response.body)['access_token']
        header "Authorization", "OAuth #{@access_token}"
    end
  end


  def test_api_streak_add
    post '/api/streaks/add'
    assert last_response.ok?
    puts Streak.all[0]
    assert_equal 'TBD', last_response.body
  end
end
