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
    resources :products do
      resources :product_variants
    end
  end

  resources :products do
    resources :product_variants
  end

  get '/search', to: 'products#search', as: 'search/result'
  put '/orders', to: 'orders#create', as: 'order'
  delete '/orders.:id', to:'orders#destroy'

  get '/search_suggestions', to: 'products#search_suggestions'


  resources :ordered_items

  namespace :admin do

    resources :products do
      resources :product_variants
    end

    resources :admin_panels
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

    resources :orders do
      resources :ordered_items
    end

    get '/product', to: 'admin_panels#all_products', as: :all_product

  end

  resources :cart
  get '/cart', to: 'cart#show'

end
