GoodOrEvil::Application.routes.draw do
  
  root to: 'posts#index'
  get '/posts', to: 'posts#index', as: 'posts'
  post '/posts', to: 'posts#create'
  delete '/posts/:id', to: 'posts#destroy'
  patch '/posts/:id', to: 'posts#update'

end
