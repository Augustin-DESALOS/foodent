class Recipe < ApplicationRecord
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients


  def display_ingredients
    recipe_ingredients.map do |ri|
      "#{ri.quantity} #{ri.ingredient.name}"
    end
  end
end
