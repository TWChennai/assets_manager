Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)

  resources :users, :only => [:show, :index] do
    collection do
      post :search
    end
  end

  resources :accessories, :only => [:show, :index], :controller => :assets do
    collection do
      post :search
      get :common
    end
  end

  post '/assign' => 'home#assign'
  root to: 'home#index'
end
