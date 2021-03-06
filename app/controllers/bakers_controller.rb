require 'pry'
require 'sinatra/base'
require 'rack-flash'

class BakersController < ApplicationController
  enable :sessions
  use Rack::Flash

  #SignUp
  get "/signup" do
    if !logged_in?
      erb :"/bakers/create_baker"
    else
      redirect "/bakers/show_dashboard"
    end
  end

  post "/signup" do
    @baker = Baker.new(username: params[:username], email: params[:email], password: params[:password])
    if @baker.save
      session[:baker_id] = @baker.id
      redirect "/bakers/show_dashboard"
    else
      flash[:message] = @baker.errors.full_messages.to_sentence
      erb :"/bakers/create_baker"
    end
  end

  #LogIn
  get "/login" do
    if logged_in?
      redirect "/bakers/show_dashboard"
    else
      erb :"/bakers/login_baker"
    end
  end

  post "/login" do
    baker = Baker.find_by(username: params[:username])
    if baker && baker.authenticate(params[:password])
      session[:baker_id] = baker.id
      redirect "/bakers/show_dashboard"
    else
      flash[:message] = "Error! invalid username or password, try again."
      redirect "/login"
    end
  end

  #ShowDashboard
  get "/bakers/:id" do
    @baker = Baker.find_by_id(params[:id])
    erb :"/bakers/show_dashboard"
  end

  #LogOut
  get '/logout' do
    if logged_in?
      session.clear
      redirect "/login"
    else
      redirect to '/'
    end
  end
end
