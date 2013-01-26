require 'rack/csrf'

class DeleteReason
  include MongoMapper::Document

  key :email, String, :required => true
  key :reason, String, :required => true
  key :account_age_in_days, Float, :required => true
  key :account_created, Time, :required => true

  timestamps!
end


class MmUser
  include MongoMapper::Document

  validates_presence_of :email
end


class Focusstreak < Sinatra::Base
  set :sinatra_authentication_view_path, Pathname(__FILE__).dirname.expand_path + 'views/'

  configure :development do
    require "sinatra/reloader"
    register Sinatra::Reloader
  end

  get '/' do
    @users = User.all
    @page_title = 'Home'
    haml :index
  end

  get '/login' do
    haml :login
  end

  get '/signup' do
    if logged_in?
      redirect '/'
    end

    haml :signup
  end

  post '/signup' do
    user_params = params[:user]

    if not params.has_key?('tos')
      @email = user_params[:email]
      @error = 'You must accept the Terms and Conditions'
      return haml :signup
    end

    @user = User.set(user_params)

    if @user.valid && @user.id
      session[:user] = @user.id
      redirect '/'
    else
      @email = user_params[:email]
      @error =  "#{@user.errors}."
      haml :signup
    end
  end

  get '/delete_account' do
    login_required
    @page_title = "Delete Account"
    haml :delete_account
  end

  post '/delete_account' do
    login_required
    @page_title = "Delete Account"

    if not User.authenticate(current_user.email, params[:password])
      @reason = params[:reason]
      @error = "Incorrect Password"
      return haml :delete_account
    end

    DeleteReason.create(:email => current_user.email,
                        :reason => params[:reason],
                        :account_created => current_user.created_at,
                        :account_age_in_days => ((Time.now - current_user.created_at) / 60 / 60 / 24).round(3))

    current_user.destroy
    session[:user] = nil
    redirect '/'
  end

  get '/settings' do
    login_required
    @user = current_user
    haml :settings
  end

  post '/settings' do
    login_required

    user_attributes = params[:user]

    password = params[:old_password]
    salt = current_user.salt

    user_attributes = params[:user]

    if user_attributes[:password] == ""
      user_attributes.delete("password")
      user_attributes.delete("password_confirmation")
      user_attributes[:password] = params[:old_password]
    end

    user = current_user

    if not User.authenticate(user.email, password)
      @error = "'Current password' was incorrect"
    elsif user.update(user_attributes)
      @notice = "Settings updated."
    else
      @error = "There were some problems with your settings: #{user.errors}."
    end

    haml :settings
  end

  # Kept at the bottom so we can overwrite default routes
  register Sinatra::SinatraAuthentication

  helpers do
    def h(text)
      Rack::Utils.escape_html(text)
    end
  end
end
