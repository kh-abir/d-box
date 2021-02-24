Rails.application.routes.draw do
  resources :home
  root to: 'home#index'

  get '/all_products', to: 'home#all_products'
  get '/search', to: 'products#search', as: 'search/result'
  get '/search_suggestions', to: 'products#search_suggestions'
  post '/save_user_to_notify', to: 'home#save_user_to_notify'
  delete '/delete_user_notification', to: 'home#delete_user_notification'
  get '/check_coupon', to: 'home#check_coupon'
  post '/process_payment', to: 'orders#process_payment'
  get '/show_invoice', to: 'orders#show_invoice'


  devise_for :users, controllers: {
      registrations: 'registrations'
  }
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
    get '/reports', to: 'admin_panels#reports', as: :reports
    post '/admin_panels/reports', to: 'admin_panels#reports'

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
