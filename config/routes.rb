Rails.application.routes.draw do
  resources :home
  root to: 'home#index'
  get '/check_coupon', to: 'cart#check_coupon'
  post '/update_total', to: 'orders#update_total'

  get '/all_products', to: 'home#all_products'
  get '/search', to: 'products#search', as: 'search/result'
  get '/search_suggestions', to: 'products#search_suggestions'

  devise_for :users
  resources :orders
  resources :ordered_items
  resources :cart

  resources :sub_categories do
    resources :products
  end

  namespace :admin do
    resources :admin_panels
    resources :discount
    resources :coupon
    get '/product', to: 'admin_panels#all_products', as: :all_product
    get '/reports', to: 'admin_panels#reports', as: :reports

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

end
