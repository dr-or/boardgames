Rails.application.routes.draw do
  devise_for :users
  root 'games#index'

  resources :games do
    resources :comments, only: %i[create destroy]
    resources :subscriptions, only: %i[create destroy]
    resources :photos, only: %i[create destroy]
  end
  resources :users, only: %i[edit update show]
end
