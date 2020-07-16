# frozen_string_literal: true

Rails.application.routes.draw do
  get "users/show"
  devise_for :users, controllers: {
        registrations: "users/registrations",
        omniauth_callbacks: "users/omniauth_callbacks"
  }
  resources :books
  resources :users, only: [:show]
  root to: "books#index"
end
