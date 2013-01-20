require 'rubygems'
require 'sinatra'
require 'sinatra/base'
require 'mongo_mapper'
require 'sinatra-authentication'
require 'haml'
require 'rack/csrf'

class MmUser
  include MongoMapper::Document

  validates_presence_of :email
end


class Focusstreak < Sinatra::Base
  set :sinatra_authentication_view_path, Pathname(__FILE__).dirname.expand_path + 'views/'

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

  get '/user/:nickname' do
    @user = MmUser.find_by_nickname(params[:nickname])
    haml :show
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
      @error =  "#{@user.errors}."
      haml :signup
    end
  end

  get '/settings' do
    login_required
    @user = current_user
    haml :settings
  end

  post '/settings' do
    login_required

    user = User.get(:id => params[:id])
    user_attributes = params[:user]

    if params[:user][:password] == ""
        user_attributes.delete("password")
        user_attributes.delete("password_confirmation")
    end

    if user.update(user_attributes)
      redirect '/'
    else
      @error = "There were some problems with your updates: #{user.errors}."
      redirect "/settings/#{user.id}?"
    end
  end

  register Sinatra::SinatraAuthentication
end
