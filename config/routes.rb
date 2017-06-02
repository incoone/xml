Rails.application.routes.draw do
  get 'home/index'

  get '/user/', to: 'home#show'
  post '/user/', to: 'home#show'
  get '/user/', to: 'home#index'
  post '/apply/', to: 'home#apply'
  get '/apply/', to: 'home#index'

  get '/admin/', to: 'admin#index'
  get '/admin/:id', to: 'admin#id'
  post '/admin/:id/info/', to: 'admin#info'
  post '/admin/:id/event/', to: 'admin#event'
  post '/admin/:id/eventDel/', to: 'admin#eventDel'
  post '/admin/:id/customer/', to: 'admin#customer'
  post '/admin/:id/customerDel/', to: 'admin#customerDel'
  post '/admin/:id/eventAdd/', to: 'admin#eventAdd'
  post '/admin/:id/customerAdd/', to: 'admin#customerAdd'
  post '/admin/:id/pay/', to: 'admin#pay'

  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
