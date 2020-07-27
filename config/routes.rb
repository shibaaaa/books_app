# frozen_string_literal: true

Rails.application.routes.draw do
  get "users/show"
  devise_for :users, controllers: {
        registrations: "users/registrations",
        omniauth_callbacks: "users/omniauth_callbacks"
  }

  resources :users do
    resources :followings, only: :index, controller: "users/followings"
    resources :followers, only: :index, controller: "users/followers"
  end

  resources :follows, only: [:create, :destroy]
  resources :books
  resources :users, only: [:show]
  root to: "books#index"
end
