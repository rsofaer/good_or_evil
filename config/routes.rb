GoodOrEvil::Application.routes.draw do

  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"}
  root :to => "site#index"
  resources :posts
  get '/profile/', to: 'site#show', as: 'profile'
  post '/posts', to: "posts#create"
  post '/posts/:id/like', to: 'posts#like'
  post '/posts/:id/comments', to: 'posts#create_comment'


end

#  Prefix Verb   URI Pattern                    Controller#Action
#         new_user_session GET    /users/login(.:format)         devise/sessions#new
#             user_session POST   /users/login(.:format)         devise/sessions#create
#     destroy_user_session DELETE /users/logout(.:format)        devise/sessions#destroy
#            user_password POST   /users/password(.:format)      devise/passwords#create
#        new_user_password GET    /users/password/new(.:format)  devise/passwords#new
#       edit_user_password GET    /users/password/edit(.:format) devise/passwords#edit
#                          PATCH  /users/password(.:format)      devise/passwords#update
#                          PUT    /users/password(.:format)      devise/passwords#update
# cancel_user_registration GET    /users/cancel(.:format)        devise/registrations#cancel
#        user_registration POST   /users(.:format)               devise/registrations#create
#    new_user_registration GET    /users/sign_up(.:format)       devise/registrations#new
#   edit_user_registration GET    /users/edit(.:format)          devise/registrations#edit
#                          PATCH  /users(.:format)               devise/registrations#update
#                          PUT    /users(.:format)               devise/registrations#update
#                          DELETE /users(.:format)               devise/registrations#destroy
#                     root GET    /                              site#index
#                    posts GET    /posts(.:format)               posts#index
#                          POST   /posts(.:format)               posts#create
#                 new_post GET    /posts/new(.:format)           posts#new
#                edit_post GET    /posts/:id/edit(.:format)      posts#edit
#                     post GET    /posts/:id(.:format)           posts#show
#                          PATCH  /posts/:id(.:format)           posts#update
#                          PUT    /posts/:id(.:format)           posts#update
#                          DELETE /posts/:id(.:format)           posts#destroy
#                  profile GET    /profile/:id(.:format)         site#show
#                          POST   /posts(.:format)               posts#create
#                          POST   /posts/:id/like(.:format)      posts#like
#                          POST   /posts/:id/comments(.:format)  posts#create_comment
