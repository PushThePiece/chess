Rails.application.routes.draw do
  devise_for :users
  root 'games#index'
  resources :games, :only => [:index, :create, :update, :show]
  resources :pieces, :only => [:show, :update]
end
