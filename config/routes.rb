Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/merchants/find', to: 'merchants_search#find'
      get '/items/find_all', to: 'items_search#find_all'
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index], controller: 'merchant_items'
      end
      resources :items do
        resources :merchant, only: [:index], controller: 'item_merchants'
      end
    end
  end
end
