Rails.application.routes.draw do
  root :to => "home#index"
  get "/welcome" => "welcome#index"

  get "/m/new" => "onemessages#new"
  post "/m/new" => "onemessages#create"
  get "/m/edit" => "onemessages#edit"
  patch "/m/edit" => "onemessages#update"

  get "/pr/new" => "profiles#new"
  post "/pr/new" => "profiles#create"
  get "/pr/edit" => "profiles#edit"
  patch "/pr/edit" => "profiles#update"

  get "/p/new" => "posts#new"
  post "/p/new" => "posts#create"
  get "/p/:id/edit" => "posts#edit"
  patch "/p/:id/edit" => "posts#update"
  get "/p/:id/destroy" => "posts#destroy"
  get "/p/:id" => "posts#show"

  get "/p/:id/like" => "likes#create"
  get "/p/:id/unlike" => "likes#destroy"

  post "/c/:id/new" => "comments#create"
  patch "/c/:id/edit" => "comments#update"
  get "/c/:id/destroy" => "comments#destroy"

  post "/r/:id/new" => "replies#create"
  patch "/r/:id/edit" => "replies#update"
  get "/r/:id/destroy" => "replies#destroy"

  get "/search/check" => "search#check"
  get "/u/search/:word" => "search#user"
  get "/pr/search/:word" => "search#profile"
  get "/p/search/:word" => "search#post"
  get "/unmatch/:word" => "search#unmatch"
  get "/u/s/random" => "search#user_random"
  get "/p/s/random" => "search#post_random"

  get "/f/count" => "home#follow_count"

  get "/h/help" => "helps#help"
  get "/h/terms" => "helps#terms"
  get "/h/privacy" => "helps#privacy"
  get "/h/cookie" => "helps#cookie"
  get "/h/howto" => "helps#howto"
  get "/h/contact" => "helps#contact"

  get :rank_posts, controller: :application
  get :reco_users, controller: :home
  get :notice_items, controller: :home

  resources :users, param: :userid, path: "/", only: [:show]

  get "/:userid/follow" => "follows#create"
  get "/:userid/unfollow" => "follows#destroy"

  devise_for :users, :controllers => {
                       :omniauth_callbacks => "users/omniauth_callbacks",
                       :registrations => "users/registrations",
                       :sessions => "users/sessions",
                     }

  devise_scope :user do
    get "/sign_up", :to => "users/registrations#new"
    get "/sign_in", :to => "users/sessions#new"
    get "/sign_out", :to => "users/sessions#destroy"
    delete "/user" => "users/registrations#destroy", as: :destroy_user_registration
  end

  get "*not_found", to: "application#routing_error"
  post "*not_found", to: "application#routing_error"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
