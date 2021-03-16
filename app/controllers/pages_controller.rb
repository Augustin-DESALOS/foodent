class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end
  def dashboard
    #@price = current_user.budget
    #if Date.today.yday - (current_user.lists.last.created_at.yday) > 7  
      #@list = 
      #@list =
      #@list =
    #else
    #end
  end
end
