# frozen_string_literal: true

require 'sinatra'
require 'sinatra/base'
require 'sinatra/flash'
require_relative './lib/spaces.rb'
require_relative './lib/user.rb'
require_relative './lib/request.rb'

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

    Spaces.create(title: params[:title], description: params[:description], price_per_night: params[:price_per_night], owner_id: session[:user_id] )
    redirect '/spaces'
  end

  get '/logout' do
    session.clear
    flash[:notice] = 'You have signed out.'
    redirect '/'
  end

  get '/book/:id' do
    flash[:notice] = 'Request was sent.'
    space_id = params[:id]
    owner_id = Spaces.fetch_owner_id(space_id)
    requester_id = session[:user_id]
    Request.create(space_id, owner_id, requester_id)
    redirect '/spaces'
  end

  # my requests route
  get '/my_requests' do
    @user_id = session[:user_id]
    "@list_as_guest = "
    @list_as_guest = Request.list_for_guest(@user_id)
    if @list_as_guest == []
      @list_as_guest_m = 0
    else
      "@list_as_guest_m = "
      @list_as_guest_m = @list_as_guest.map do |element|
        [Request.fetch_info(element.owner_id),
          Request.fetch_space_info(element.property_id),
          element.status]
      end
    end


    # as owner
    @list_as_owner = Request.list_for_host(@user_id)
      if @list_as_owner == []
        @list_as_owner_m = 0
      else
        @list_as_owner_m = @list_as_owner.map do |element|
          [Request.fetch_info(element.requester_id),
            Request.fetch_space_info(element.property_id),
            element.status]

          end
      end

    erb :'user/myrequest'
  end
end
