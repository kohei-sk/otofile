Rails.application.routes.draw do
  root :to => "home#index"
  get "welcome" => "welcome#index"

  get "follows/create"
  get "follows/destroy"

  get "m/new" => "onemessages#new"
  post "m/new" => "onemessages#create"
  get "m/edit" => "onemessages#edit"
  patch "m/edit" => "onemessages#update"

  get "pr/new" => "profiles#new"
  post "pr/new" => "profiles#create"
  get "pr/edit" => "profiles#edit"
  patch "pr/edit" => "profiles#update"

  get "p/new" => "posts#new"
  post "p/new" => "posts#create"
  get "p/:id/edit" => "posts#edit"
  patch "p/:id/edit" => "posts#update"
  get "p/:id/destroy" => "posts#destroy"

  get "p/:id/like" => "likes#create"
  get "p/:id/unlike" => "likes#destroy"

  get "f/list" => "friends#show"

  resources :users, param: :userid, path: "/", only: [:show]

  get ":userid/follow" => "follows#create"
  get ":userid/unfollow" => "follows#destroy"

  devise_for :users, :controllers => {
                       :omniauth_callbacks => "users/omniauth_callbacks",
                       :registrations => "users/registrations",
                       :sessions => "users/sessions",
                     }

  devise_scope :user do
    get "sign_up", :to => "users/registrations#new"
    get "sign_in", :to => "users/sessions#new"
    get "sign_out", :to => "users/sessions#destroy"
    delete "user" => "users/registrations#destroy", as: :destroy_user_registration
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
