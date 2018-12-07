require 'sidekiq/web'
Rails.application.routes.draw do
  root 'dashboards#index'

  resources :pokemons, only: %i(index) do
    collection do
      match :import, via: %I(get post)
      match :export, via: %I(get)
      match :remove_all, via: %I(get)
    end
  end

  devise_for :users

  mount Sidekiq::Web, at: '/sidekiq', as: 'sidekiq'
end
