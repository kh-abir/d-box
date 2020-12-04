Rails.application.routes.draw do
  get 'cart/show'
  resources :home

  devise_for :users
  root to: 'home#index'

  resources :categories do
    member do
      get :get_subcategories
    end
  end
  get ':cat_id/all_products_by_category', to: 'products#index' , as: :all_products_by_category
  get ':sub_id/all_products_by_subcategory', to: 'products#index' , as: :all_products_by_sub_category
  get '/search', to: 'products#search', as: 'search/result'

  resources :products
  resources :product_variants
  resources :sub_categories
  resources :ordered_items

  # resources :cart
  get '/cart', to: 'cart#show'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
