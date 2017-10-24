require 'pry'

class BakersController < ApplicationController

  #SignUp
  get "/signup" do
    if !logged_in?
      erb :"/bakers/create_baker"
    else
      redirect "/bakers/show_dashboard"
    end
  end

  post "/signup" do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect '/signup'
    else
    @baker = Baker.create(username: params[:username], email: params[:email], password: params[:password])
    session[:baker_id] = @baker.id
    redirect "/bakers/show_dashboard"
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
      redirect "/signup"
    end
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

  #ShowDashboard
  get "/bakers/:id" do
    @baker = Baker.find_by_id(params[:id])
    erb :"/bakers/show_dashboard"
  end

end
