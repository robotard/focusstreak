require 'rubygems'
require 'rack/test'
require 'minitest/autorun'

ENV['RACK_ENV'] = 'test'
APP = Rack::Builder.parse_file('config.ru').first

class FocusstreakTest < Minitest::Unit::TestCase
  include Rack::Test::Methods

  @oauth_secret = nil
  @user_id = nil

  def app
    MongoMapper.database = ENV['DATABASE'] + "_#{Sinatra::Base.environment}"
    APP
  end

  def setup
    if not @oauth_secret
        MongoMapper.database.collections.each do |c|
          c.drop
        end

        client = Rack::OAuth2::Server.register(:display_name=>"TestClient",
            :link=>"http://example.com/",
            :image_url=>"http://example.com/logo.jpg",
            :scope=>%{read write},
            :redirect_uri=>"http://example.com/oauth/callback",
            :authorization_types => ['password'])
        @oauth_secret = client.secret

        @user_id = User.set({:email => "test@test.com", :password_confirmation => "test", :password => "test"}).id

        post '/oauth/access_token', {:client_secret => client.secret, :client_id => client._id, :grant_type => 'password', :username => "test@test.com", :password => "test"}
        @access_token = JSON.parse(last_response.body)['access_token']
        header "Authorization", "OAuth #{@access_token}"
    end
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

    expected = Streak.new(:name => "test name",
                          :info => "test info",
                          :duration => 123,
                          :timestamp => Time.now())


    user = user()
    user.streaks << expected
    user.save()

    get '/api/streaks'
    assert last_response.ok?
    result = JSON.parse(last_response.body).first
    assert_equal_streaks(expected, result)
  end

  def test_api_streaks_get
    expected = Streak.new(:name => "test name",
                          :info => "test info",
                          :duration => 123,
                          :timestamp => Time.now())

    user = user()
    user.streaks << expected
    user.save()

    get "/api/streaks/#{expected.id}"
    assert last_response.ok?

    result = JSON.parse(last_response.body)
    assert_equal_streaks(expected, result)

    get "/api/streaks/foobarbaz"
    refute last_response.ok?
    expected = {:error => "Streak not found"}
    assert_equal expected.to_json, last_response.body
  end

  def user
    User.get(:id => @user_id)
  end

  def user_streaks
    user.streaks
  end

  def test_api_encouragement
    get '/api/encouragement', :name => "test name",
                              :info => "test info",
                              :duration => 123,
                              :timestamp => Time.now

    assert last_response.ok?
    expected = "<H1>You're doing swell, don't give up now...</H1>"
    assert_equal expected, last_response.body
  end

  def test_api_streaks_new
    expected = Streak.new(:name => "test name",
                          :info => "test info",
                          :duration => 123,
                          :timestamp => Time.now)

    post '/api/streaks', :name => expected.name,
                         :info => expected.info,
                         :duration => expected.duration,
                         :timestamp => expected.timestamp

    assert last_response.ok?
    expected_body = {:error => false}
    assert_equal expected_body.to_json, last_response.body

    streak = user_streaks.first
    assert_equal expected.name, streak.name
    assert_equal expected.info, streak.info
    assert_equal expected.duration, streak.duration
    assert_equal expected.timestamp.to_s, streak.timestamp.to_s

    post '/api/streaks', :name => expected.name,
                         :duration => expected.duration,
                         :timestamp => expected.timestamp

    refute last_response.ok?
    expected = {:error => {:info => ["can't be blank"]}}
    assert_equal expected.to_json, last_response.body
    assert_equal 1, user_streaks.length
  end
end
