# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    post '/login' => 'sessions#create'
    get '/logout' => 'sessions#destroy'
    resources :users, only: %i[show index create update]
    resources :sales, only: %i[index show create]
    resources :carts, only: %i[index create destroy update]
    resources :favorites, only: %i[index create destroy]

    resources :brands, only: %i[index show]
    resources :styles, only: %i[index show]
    resources :categories, only: %i[index show]
    resources :drinks, only: %i[index show] do
      resources :reviews, only: %i[index create update destroy]
    end
  end
end
