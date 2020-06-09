Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'products/index'
    end
  end
  mount_devise_token_auth_for 'User', at: 'auth'
  get '/home/page_content'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
