Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  resources :recipes
  resources :ingredients
  resources :steps

  get '/index/:id', to: "users#index"
  get '/sign_up', to: 'users#sign_up'
  get '/login', to: 'users#login'
  post '/authenticate', to: 'users#authenticate'
  post '/sign-up', to: 'users#create_account'
  post '/search-user', to: 'users#search_other_user_page'
end




