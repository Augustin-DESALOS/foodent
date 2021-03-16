Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "shopping_list", to: "ingredients#shopping_list", as: :shopping_list
  resources :lists, only: [:create,:update]
  resources :recipes, only: [:index, :show]
end
