Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show] 
      resources :items
    end
  end
  get '/api/v1/merchants/:merchant_id/items', to: 'merchant_items#index'
end
