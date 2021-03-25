# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    post '/login' => 'sessions#create'
    get '/logout' => 'sessions#destroy'
    resources :users, only: %i[show index create update] do
      resources :sales, only: %i[index show create]
    end
    resources :carts, only: %i[index create destroy update]

    resources :brands, only: %i[index show]
    resources :styles, only: %i[index show]
    resources :categories, only: %i[index show]
    resources :drinks, only: %i[index show]
  end
end
