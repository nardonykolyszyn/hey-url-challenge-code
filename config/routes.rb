# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'urls#index'

  get ':url', to: 'urls#visit', as: :visit

  resources :urls, only: %i[index create], param: :url do
    get :stats, to: 'urls#show', on: :member
  end
end
