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

  post "/recipes" do
    if logged_in?
      @recipe = Recipe.new
      @recipe.baker = current_baker
      @recipe.name = params[:name]
      @recipe.ingredients = params[:ingredients]
      @recipe.instructions = params[:instructions]
      @recipe.category_ids = params[:categories]
      @recipe.save

      redirect "/recipes/#{@recipe.id}"
    end

  end
end
