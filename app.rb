# frozen_string_literal: true

require 'sinatra'
require 'sinatra/base'
require_relative './lib/spaces.rb'

class MakersBNB < Sinatra::Base
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

  get '/signup' do
    erb :signup
  end

  post '/create' do
    Spaces.create(title: params[:title], description: params[:description], price_per_night: params[:price_per_night])
    redirect '/spaces'
  end
end
