Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users
  resources :recipes
  resources :ingredients
  resources :steps
  
  get '/sign_up', to: 'users#sign_up'
  post '/sign-up', to: 'users#create_account'
  
end




