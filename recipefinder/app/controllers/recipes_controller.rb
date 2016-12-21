class RecipesController < ApplicationController
  def index
  	@search_term = 'chocolate'
  	@recipes = Recipe.for(@search_term)
  end
end
