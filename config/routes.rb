# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :products, only: %i[index create update]
      resources :tags, only: %i[index create update]
    end
  end
end
