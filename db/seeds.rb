# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'
require 'open-uri'

RecipeIngredient.destroy_all
Ingredient.destroy_all
Recipe.destroy_all

# 5.times do
#   url = "https://www.themealdb.com/api/json/v1/1/random.php"
#   meal = JSON.parse(open(url).read)["meals"].first
#   recipe = Recipe.create(
#     name: meal["strMeal"],
#     description: meal[""],
#     picture:meal["mealThumb"],
#     rating: (1..5).to_a.sample,
#     preparation: meal["strInstructions"],
#   )
#   # POur chaque ingredient (on suppose 20 au max)
#   20.times do |i|
#     # Je récupère le nom de l'ingrédient
#     ingredient = meal["strIngredient#{i}"] # "Aubergine"
#     # Si y'a un nom
#     if !ingredient.blank? 
#       # Je regarde si je connais cet ingrédient en DB
#       db_ingredient = Ingredient.find_by_name(ingredient)
#       # Si je le connais pas
#       if !db_ingredient
#         # Je le crée
#         db_ingredient = Ingredient.create(
#           name: ingredient
#         )
#       end
      
#       ri = RecipeIngredient.create(
#         recipe: recipe,
#         ingredient: db_ingredient,
#         quantity: meal["strMeasure#{i}"]
#       )
#       p ri
#     end
#   end
# end

require "open-uri"
require "nokogiri"

html = open("https://www.marmiton.org/recettes/index/categorie/plat-principal?rcp=0").read
# 1. Parse HTML
doc = Nokogiri::HTML(html, nil, "utf-8")
# 2. For the first five results
results = []
doc.search(".recipe-card").first(1).each do |element|
  # 3. Create recipe and store it in results
  name = element.search(".recipe-card__title").first.text.strip
  recipe_url = element.search(".recipe-card-link").first.attributes["href"].value
  description = element.search(".recipe-card__description").first.text.strip
  rating = element.search(".recipe-card__rating__value").first.text.strip
  prep_time = element.search(".recipe-card__duration__value").first.text.strip
  recipe = Recipe.create(name: name, description: description, rating: rating, cooking_time: prep_time)

   p recipe_url

  recipe_html = open(recipe_url).read
  recipe_doc = Nokogiri::HTML(recipe_html, nil, "utf-8")
  recipe_doc.search(".ingredient-list__ingredient-group li").each do |ingredient|
    ingredient_name =  ingredient.search(".item__ingredient .ingredient-name").first.text.strip
    ingredient_quantity = ingredient.search(".item__quantity .quantity").first.text.strip
    ingredient_unit = ingredient.search(".item__quantity .unit").first.text.strip
    if !ingredient_name.blank? 
      # Je regarde si je connais cet ingrédient en DB
      db_ingredient = Ingredient.find_by_name(ingredient_name)
      # Si je le connais pas
      if !db_ingredient
        # Je le crée
        db_ingredient = Ingredient.create(
          name: ingredient_name
        )
      end
      
      ri = RecipeIngredient.create(
        recipe: recipe,
        ingredient: db_ingredient,
        quantity: ingredient_quantity,
        unit: ingredient_unit
      )
      puts ri
    end
  end
end
