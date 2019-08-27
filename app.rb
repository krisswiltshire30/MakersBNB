require 'sinatra/base'
require 'sinatra'


class MakersBNB < Sinatra::Base

  get '/' do
    erb  :index
  end 
  get '/spaces' do
    erb :spaces
  end  
end
