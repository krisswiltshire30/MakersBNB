# frozen_string_literal: true

require 'sinatra'
require 'sinatra/base'
require_relative './lib/spaces.rb'
require_relative './lib/user.rb'

class MakersBNB < Sinatra::Base
  enable :sessions

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
    erb :'user/index'
  end

  get '/signup' do
    erb :signup
  end

  get '/login' do
    erb :login
  end

  post '/login' do
    erb :login
  end

  post '/signup' do
    @user = User.create(email: params[:email], password: params[:password])
    erb :login
  end

  post '/create' do
    Spaces.create(title: params[:title], description: params[:description], price_per_night: params[:price_per_night])
    redirect '/spaces'
  end
end
