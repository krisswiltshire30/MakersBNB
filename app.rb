# frozen_string_literal: true

require 'sinatra'
require 'sinatra/base'
require 'sinatra/flash'
require_relative './lib/spaces.rb'
require_relative './lib/user.rb'

class MakersBNB < Sinatra::Base
  enable :sessions
  register Sinatra::Flash
  get '/' do
    erb :index
  end

  get '/spaces' do
    @spaces = Spaces.all
    erb :spaces
  end

  get '/create' do
    erb :'spaces/add'
  end

  get '/user/index' do
    @logged_user = session[:logged_user]
    erb :'user/index'
  end

  get '/signup' do
    erb :signup
  end

  get '/login' do

    erb :login
  end

  post '/login' do
    @new_user = User.authenticate(email: params[:email], password: params[:password])
    session[:logged_user] = @new_user
    if @new_user
      session[:user_id] = @new_user.id
      redirect('/user/index')
    else
      flash[:notice] = 'Please check your email or password.'
      redirect('/login')
    end
  end

  post '/signup' do

      if params[:password] != params[:password_confirmation]
        flash[:notice] = 'Your passwords are not the same.'
        redirect '/signup'
      else
        @user = User.create(email: params[:email], password: params[:password])
        session[:user] = @user
        session[:user_id] = @user.id
        erb :login
        redirect '/login'
      end

  end

  post '/create' do
    Spaces.create(title: params[:title], description: params[:description], price_per_night: params[:price_per_night])
    redirect '/spaces'
  end
end
