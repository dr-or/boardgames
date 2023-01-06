Rails.application.routes.draw do
  devise_for :users
  root 'games#index'

  resources :games
  resources :users, only: %i[edit update show]
end
