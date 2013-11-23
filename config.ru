require 'bundler'
Bundler.require

require 'dotenv'
Dotenv.load

require 'rack/csrf'
require 'rack-flash'

require './app'
require './stripcookies'


Focusstreak.set :project_name, 'Focus Streak'
Focusstreak.set :google_analytics, ENV['GOOGLE_ANALYTICS']

use Rack::StripCookiesFromAPICalls
use Rack::Deflater
use Rack::Session::EncryptedCookie, :expire_after => 3600*24*60, :secret => ENV['COOKIE_SECRET']
use Rack::Csrf, :raise => true, :skip => ['POST:/oauth/.*', 'POST:/api/.*']
use Rack::Flash, :sweep => true

logger = Logger.new($stdout)
MongoMapper.connection = Mongo::Connection.new(ENV['DATABASE_HOST'], ENV['DATABASE_PORT'], :logger => logger)
MongoMapper.database = ENV['DATABASE'] + "_#{Sinatra::Base.environment}"
MongoMapper.database.authenticate(ENV['DATABASE_USER'], ENV['DATABASE_PASSWORD'])

Pony.options = { :from => "#{Focusstreak.project_name} <#{ENV['EMAIL_FROM']}>",
                 :via => :smtp,
                 :via_options => {
                   :openssl_verify_mode => OpenSSL::SSL::VERIFY_NONE,
                   :address => ENV['EMAIL_HOST'],
                   :user_name => ENV['EMAIL_USER'],
                   :password => ENV['EMAIL_PASSWORD'],
                   :authentication => :login,
                   :port => 587,
                   :enable_starttls_auto => false
               } }

run Focusstreak
