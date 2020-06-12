Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  namespace :api do
    namespace :v1 do
      resources :save_addresses
      resources :products
    end
  end
  mount_devise_token_auth_for 'User', at: 'auth'
  get '/home/page_content'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
