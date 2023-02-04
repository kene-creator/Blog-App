Rails.application.routes.draw do
  devise_for :users
  root 'users#index'

 resources :users, only: [:index, :show] do 
    resources :posts, only: [:index, :new, :create, :destroy]
    resources :posts, only: [:show] do 
      resources :comments, only: [:new, :create, :destroy]
      resources :likes, only: [:create]
    end
  end

  namespace :api do
    resources :users, only: [:index] do
      resources :posts, only: [:index] do
        resources :comments, only: [:index, :create]
      end
    end
  end

end
