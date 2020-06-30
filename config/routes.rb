# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :products, only: [:create]
      resources :tags, only: %i[create update]
    end
  end
end
