class RecipesController < ApplicationController

  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def search_recipes
    if params[:query].present?
      @recipes = Recipe.search_recipes(params[:query])
    else
      render :index
    end
end

end
