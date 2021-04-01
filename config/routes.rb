# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    post '/login' => 'sessions#create'
    get '/logout' => 'sessions#destroy'
    resources :users, only: %i[index]
    post '/signup', to: 'users#create'
    get '/profile', to: 'users#show'
    patch '/profile', to: 'users#update'

    resources :sales, only: %i[index show create]
    resources :carts, only: %i[index create destroy update]
    resources :favorites, only: %i[index create destroy]

    resources :brands, only: %i[index show]
    resources :styles, only: %i[index show]
    resources :categories, only: %i[index show]
    resources :drinks, only: %i[index show] do
      resources :reviews, only: %i[index create update destroy]
    end

    get '/top-high-rated-drinks', to: 'drinks#top_most_high_rated'
    get '/top-recent-drinks', to: 'drinks#top_recent_drinks'
    get '/best-sellings', to: 'drinks#best_sellings'
  end
end
