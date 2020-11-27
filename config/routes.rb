Rails.application.routes.draw do
  get 'home/index'
  devise_for :users
  root to: 'home#index'

  resources :categories do
    member do
      get :get_subcategories
    end
  end

  resources :products
  resources :product_variants
  resources :sub_categories
  resources :ordered_items

  get '/cart', to: 'ordered_items#index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
