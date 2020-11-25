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
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
