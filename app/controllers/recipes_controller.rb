require 'pry'
require 'awesome_print'

class RecipesController < ApplicationController


  get "/recipes" do
    @recipes = Recipe.all
    erb :"/recipes/recipes"
  end

  get "/recipes/new" do
    @categories = Category.all
    erb :"/recipes/create_recipe"
  end

  get '/recipes/:id' do
     @recipe = Recipe.find_by_id(params[:id])
     erb :"/recipes/show_recipe"
   end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by_id(params[:id])
    if @recipe.baker == current_baker
      erb :"/recipes/edit_recipe"
    else
      redirect "/recipes/#{@recipe.id}"
    end
  end

  post "/recipes" do
    # Need to validate creating a recipe!
    if logged_in?
      @recipe = Recipe.new
      @recipe.name = params[:name]
      @recipe.ingredients = params[:ingredients]
      @recipe.instructions = params[:instructions]
      @recipe.baker = current_baker
      @recipe.category_ids = params[:categories]
      @recipe.save

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
      @recipe.category_ids = params[:categories]
      @recipe.save

      redirect "/recipes/#{@recipe.id}"
    end
  end

end
