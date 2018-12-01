Rails.application.routes.draw do
  root 'dashboards#index'

  resources :pokemons, only: %i(index) do
    collection do
      match :import, via: %I(get post)
    end
  end
end
