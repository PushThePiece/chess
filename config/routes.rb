Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#index'
  resources :games
  resources :pieces, :only => [:show, :update]
end
