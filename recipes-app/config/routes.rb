Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users
  resources :recipes
  resources :ingredients
  resources :steps

  # Homepage '/'
  get '/', to: 'homepage#index'
  
  # Recipes
  delete '/delete/:id', to: "recipes#destroy"
  post '/recipes', to: "recipes#create"

  #Ingredients
  get '/ingredients/:id/quantity/increment', to: 'ingredients#increment_quantity'
  get '/ingredients/:id/quantity/decrement', to: 'ingredients#decrement_quantity'

  post '/ingredients', to: 'ingredients#destroy'
  
  #Users
  get '/index/:id', to: "users#index"
  get '/sign_up', to: 'users#sign_up'
  get '/login', to: 'users#login'
  get '/logout', to: 'users#logout'
  post '/authenticate', to: 'users#authenticate'
  post '/sign-up', to: 'users#create_account'
  post '/search-user', to: 'users#search_other_user_page'

  #clear session
  post '/clear_session.rb', to: 'users#clear_session'

  #dont ask
  post '/refreshSession', to: 'users#refresh_session'
end




