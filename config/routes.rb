require 'sidekiq/web'
Rails.application.routes.draw do
  authenticate :user, lambda { |u| u.super_admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
  mount LetterOpenerWeb::Engine, at: "/letter_opener"
  root to: 'home#index'

  resources :home
  resources :orders
  resources :ordered_items

  get '/all_products', to: 'home#all_products'
  get '/search', to: 'products#search', as: 'search/result'
  get '/search_suggestions', to: 'products#search_suggestions'
  post '/save_user_to_notify', to: 'home#save_user_to_notify'
  delete '/delete_user_notification', to: 'home#delete_user_notification'
  get '/check_coupon', to: 'home#check_coupon'
  delete '/remove_coupon', to: 'home#remove_coupon'
  post '/process_payment', to: 'orders#process_payment'
  get '/show_invoice', to: 'orders#show_invoice'
  put '/store_user_cart', to: 'orders#store_user_cart'
  get '/carts', to: 'carts#index', as: :carts
  post '/add_to_cart', to: 'carts#add_to_cart'
  patch '/update_cart', to: 'carts#update_cart', as: :update_cart
  delete '/remove_cart_item', to: 'carts#remove_cart_item', as: :remove_cart_item

  devise_for :users, controllers: {
      registrations: 'registrations'
  }

  namespace :admin do
    get '/reports', to: 'admin_panels#reports', as: :reports
    post '/admin_panels/reports', to: 'admin_panels#reports'
    post '/search_products', to: 'products#search_products', as: :search_products
    post '/products_search_suggestion', to: 'products#products_search_suggestion', as: :products_search_suggestion
    post '/search_variants', to: 'product_variants#search_variants', as: :search_variants
    post '/variants_search_suggestion', to: 'product_variants#variants_search_suggestion', as: :variants_search_suggestion
    post '/search_orders', to: 'orders#search_orders', as: :search_orders
    post '/orders_search_suggestion', to: 'orders#orders_search_suggestion', as: :orders_search_suggestion

    resources :admin_panels
    resources :discount
    resources :coupon
    resources :banners

    resources :products do
      resources :product_variants
    end

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
  end

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

  resources :sub_categories do
    resources :products
  end
end
