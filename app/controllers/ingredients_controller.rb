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
    @list_ingredients = @list.list_ingredients
  end
  def create_list_ingredients
    @list = List.find(params[:id])
    @recipes = @list.recipes
    @ingredients = @recipes.map {|recipe| recipe.ingredients}.flatten
    @list_ingredients = []
    @ingredients.each do |ingredient|
      list_ingredient = ListIngredient.create(list: @list, ingredient: ingredient, checked: false)
      @list_ingredients << list_ingredient
    end
    redirect_to shopping_list_path(@list)
  end
end
