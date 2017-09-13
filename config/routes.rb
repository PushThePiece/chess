Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  
  root 'games#index'
  resources :games, :only => [:index, :create, :update, :show, :destroy] do
    patch 'forfeit', on: :member
  end
  resources :pieces, :only => [:show, :update]
end
