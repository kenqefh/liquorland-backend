# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    post '/login' => 'sessions#create'
    get '/logout' => 'sessions#destroy'
  end
end
