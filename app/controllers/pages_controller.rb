class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end
  def dashboard
    budget = params[:budget]
    @counter = 0
    recipe_price = Recipe.last.ingredients.each do |ingredient|
      @counter += ingredient.price
    end
    @counter /= 4

    # @list = Recipe.all
    # @list
    @list = Recipe.all.sample(14)

    #@price = current_user.budget
    #if Date.today.yday - (current_user.lists.last.created_at.yday) > 7  
      #@list = 
      #@list =
      #@list =
    #else
    #end
  end
end
