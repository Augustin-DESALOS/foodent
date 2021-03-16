class IngredientsController < ApplicationController
  def shopping_list
    @recipes = current_user.lists.last.recipes
    @ingredients = []
    @recipes.each do |recipe|
      @ingredients << recipe.recipe_ingredients
    end
  end
end
