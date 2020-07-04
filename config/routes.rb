# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'urls#index'

  get ':url', to: 'urls#visit', as: :visit

  resources :urls, only: %i[create], param: :url do
    get :stats, to: 'urls#show', on: :member
  end

  namespace :api do
    namespace :v1 do
      resources :urls, only: :index
    end
  end
end
