Rails.application.routes.draw do
  get 'home/index'

  get '/user/', to: 'home#show'
  post '/user/', to: 'home#show'
  get '/user/', to: 'home#index'
  post '/apply/', to: 'home#apply'
  get '/apply/', to: 'home#index'

  get '/admin/', to: 'admin#index'
  get '/admin/:id', to: 'admin#id'

  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
