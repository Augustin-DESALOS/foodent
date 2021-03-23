Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get "dashboard", to: "pages#dashboard", as: :dashboard
  get "my_list", to: "pages#my_list", as: :my_list
  post "save_list", to: "pages#save_list", as: :save_list
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :ingredients, only: [:update]
  get "shopping_list", to: "ingredients#shopping_list", as: :shopping_list
  resources :lists, only: [:create,:update]
  resources :recipes, only: [:index, :show]
  get 'recipes_search', to: 'recipes#search_recipes', as: :search_recipes
end
