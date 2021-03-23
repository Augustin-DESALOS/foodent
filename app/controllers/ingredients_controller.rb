class IngredientsController < ApplicationController
  def shopping_list
    # @recipes = current_user.lists.last.recipes
    # @ingredients = []
    # @recipes.each do |recipe|
    #   @ingredients << recipe.recipe_ingredients
    # end
    # @recipes = Recipe.where(user: current_user)
    # @list = current_user.lists.last
    @list = List.find(params[:id])
    @recipes = @list.recipes
    @ingredients = @recipes.map {|recipe| recipe.ingredients}.flatten
  end
end
