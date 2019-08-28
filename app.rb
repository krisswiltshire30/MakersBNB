require 'sinatra'
require 'sinatra/base'
require_relative './lib/spaces.rb'

class MakersBNB < Sinatra::Base

  get '/' do
    erb  :index
  end
  get '/spaces' do
    @spaces = Spaces.all
    erb :spaces
  end
end
