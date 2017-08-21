Rails.application.routes.draw do
  devise_for :users
  root 'games#index'
  resources :games
  resources :pieces, :only => [:show, :update]
end
