ENV['RACK_ENV'] ||= 'development'
require 'sinatra/flash'
require 'sinatra/base'
require './app/models/database_setup'

class MakersBnb < Sinatra::Base
  enable :sessions
  use Rack::MethodOverride
  set :session_secret, 'super secret'
  register Sinatra::Flash

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end

  get '/' do
    redirect '/signup'
  end

  get '/signup' do
    erb :signup
  end

  post '/signup' do
    @user = User.create(username: params[:username],
                          email: params[:email],
                          password: params[:password])

    if @user.save
      session[:user_id] = @user.id
      redirect '/spaces'
    else
      flash.now[:errors] = @user.errors.full_messages
      erb :'/signup'
    end
  end

  get '/spaces' do
    @username = session[:username]
    @space_name = session[:space_name]
    @space_description = session[:space_description]
    @space_price = session[:space_price]
    @space_availability = session[:space_availability]
    erb :spaces
  end

  get '/spaces/new' do
    erb :new_space
  end

  post '/spaces/new' do
    session[:space_name] = params[:space_name]
    session[:space_description] = params[:space_description]
    session[:space_price] = params[:space_price]
    session[:space_availability] = params[:space_availability]
    redirect '/spaces'
  end

  run! if app_file == $0
end
