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

    Streak.delete_all
  end

  def assert_equal_streaks(expected, actual)
    assert_equal expected.name, actual['name']
    assert_equal expected.info, actual['info']
    assert_equal expected.duration, actual['duration']
    assert_equal expected.timestamp.to_s, Time.parse(actual['timestamp']).to_s
  end

  def test_api_streaks_list
    get '/api/streaks'
    assert last_response.ok?
    expected_body = []
    assert_equal expected_body.to_json, last_response.body

    expected = Streak.create(:name => "test name",
                             :info => "test info",
                             :duration => 123,
                             :timestamp => Time.now())

    get '/api/streaks'
    assert last_response.ok?
    result = JSON.parse(last_response.body).first
    assert_equal_streaks(expected, result)
  end

  def test_api_streaks_get
    expected = Streak.create(:name => "test name",
                             :info => "test info",
                             :duration => 123,
                             :timestamp => Time.now())

    get "/api/streaks/#{expected.id}"
    assert last_response.ok?

    result = JSON.parse(last_response.body)
    assert_equal_streaks(expected, result)
  end

  def test_api_streaks_add
    expected = Streak.new(:name => "test name",
                          :info => "test info",
                          :duration => 123,
                          :timestamp => Time.now())

    post '/api/streaks/add', :name => expected.name,
                             :info => expected.info,
                             :duration => expected.duration,
                             :timestamp => expected.timestamp

    assert last_response.ok?

    expected_body = {:error => false}
    assert_equal expected_body.to_json, last_response.body

    streak = Streak.first
    assert_equal_streaks(expected, streak)
  end
end
