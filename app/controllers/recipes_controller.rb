require 'pry'
require 'awesome_print'

class RecipesController < ApplicationController

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

        redirect "/recipes/#{@recipe.id}"
      end
    end
  end

  # Edit Recipe
  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by_id(params[:id])
    if @recipe.baker == current_baker
      erb :"/recipes/edit_recipe"
    else
      redirect "/recipes/#{@recipe.id}"
    end
  end

  patch '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    if logged_in?
      @recipe.name = params[:name]
      @recipe.ingredients = params[:ingredients]
      @recipe.instructions = params[:instructions]
      @recipe.baker = current_baker
      @recipe.category_id = params[:category_id]
      @recipe.save

      redirect "/recipes/#{@recipe.id}"
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
