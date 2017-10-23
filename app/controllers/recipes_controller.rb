class RecipesController < ApplicationController

get "/recipes" do
  @recipes = Recipe.all
  erb :"/recipes/recipes"
end

get "/recipes/new" do

end

post "/recipes" do

end

end
