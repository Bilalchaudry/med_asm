Rails.application.routes.draw do
  resources :orders
  devise_for :admin_users, :skip => [:registrations]
  resources :products do
    collection do
      get :get_product_price
    end
  end
  resources :prescriptions
  resources :users

  resources :categories
  resources :admin_users
  namespace :api do
    namespace :v1 do
      resources :save_addresses
      resources :products
      resources :prescriptions
    end
  end
  root to: 'admin_dashboard#dashboard'
  mount_devise_token_auth_for 'User', at: 'auth'
  get '/home/page_content'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
