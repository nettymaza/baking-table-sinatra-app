require 'pry'
require 'awesome_print'
require 'sinatra/base'
require 'rack-flash'

class RecipesController < ApplicationController
  enable :sessions
  use Rack::Flash

  # Recipe Index
  get "/recipes" do
    @recipes = Recipe.all
    erb :"/recipes/recipes"
  end

  #Create New Recipe
  get "/recipes/new" do
    @categories = Category.all
    erb :"/recipes/create_recipe"
  end

  get '/recipes/:id' do
     @recipe = Recipe.find_by_id(params[:id])
     erb :"/recipes/show_recipe"
   end

  post "/recipes" do
    if logged_in?
      if params[:name] == "" || params[:ingredients] == "" || params[:instructions] == ""
        redirect '/recipes/new'
      else
        @recipe = Recipe.new
        @recipe.name = params[:name]
        @recipe.ingredients = params[:ingredients]
        @recipe.instructions = params[:instructions]
        @recipe.baker = current_baker
        @recipe.category_id = params[:category_id]
        @recipe.save

        flash[:message] = "Successfully Created Recipe!"
        redirect "/recipes/#{@recipe.id}"
      end
    end
  end

  # Edit Recipe
  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by_id(params[:id])
    @categories = Category.all
    if @recipe.baker == current_baker
      erb :"/recipes/edit_recipe"
    else
      redirect "/recipes/#{@recipe.id}"
    end
  end

  patch '/recipes/:id' do
    # steps :
      # check if logged in
        #  logged in steps :
          # 1. FInd recipe
          # 2. If recipe belongs to current baker
            # baker owned recipe steps:
              # 1. Update recipe
              # 2. Set successful flash message
              # 3. Redirect to recipe show page
            # unwonwed recipe steps
              # 1. Set error flash message
              # 2. redirect to resipce index route
        # logged out steps
          # 1. Set error flash message
          # 2. redirect to login route

    if logged_in?
      @recipe = Recipe.find_by_id(params[:id])
      if @recipe.baker == curent.baker
        @recipe.update(params[:recipe])
        flash[:message] = "Successfully Updated Recipe!"
        redirect "/recipes/#{@recipe.id}"
      else
        flash[:message] = "Sorry not your recipe!"
        redirect "/recipes"
      end
    else
      flash[:message] = "You're not logged in!"
      redirect "/login"
    end
  end

  # Delete Recipe
  delete '/recipes/:id/delete' do
    @recipe = Recipe.find_by_id(params[:id])
    if logged_in? && @recipe.baker_id == current_baker.id
      @recipe.delete
      redirect '/bakers/show_dashboard'
    else
      redirect '/login'
    end
  end

end
