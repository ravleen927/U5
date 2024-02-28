Rails.application.routes.draw do
  get 'products/show'
  resources :products, only: [:index, :show]
  root to: 'products#index'
end
