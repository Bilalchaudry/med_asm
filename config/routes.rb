Rails.application.routes.draw do
  resources :products
  resources :users
  resources :product_categories
  resources :product_sub_categories
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  namespace :api do
    namespace :v1 do
      get 'products/index'
    end
  end
   root to: 'admin_dashboard#dashboard'
  mount_devise_token_auth_for 'User', at: 'auth'
  get '/home/page_content'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
