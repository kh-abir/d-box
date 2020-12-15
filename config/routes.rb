Rails.application.routes.draw do
  resources :home

  devise_for :users

  root to: 'home#index'

  get '/all_products', to: 'home#all_products'

  resources :categories do
    member do
      get :get_subcategories
    end
    resources :sub_categories do
      resources :products do
        resources :product_variants
      end
    end
  end

  resources :products do
    resources :product_variants
  end

  get ':cat_id/all_products_by_category', to: 'products#index' , as: :all_products_by_category
  get ':sub_id/all_products_by_subcategory', to: 'products#index' , as: :all_products_by_sub_category
  get '/search', to: 'products#search', as: 'search/result'
  put '/orders', to: 'orders#create', as: 'order'
  delete '/orders.:id', to:'orders#destroy'
  get '/product', to: 'admin_panels#all_products', as: :all_product

  resources :ordered_items
  resources :admin_panels
  resources :invoices

=begin
  namespace :admin do
    resources :products
    resources :product_variants
    resources :admin_panels
  end
=end


  resources :orders do
    resources :ordered_items
  end

  # resources :cart
  get '/cart', to: 'cart#show'

end
