Rails.application.routes.draw do
  root 'games#index'

  resources :games
  resources :users, only: %i[edit update show]
end
