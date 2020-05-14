Rails.application.routes.draw do
  root :to => "home#index"
  get "users/show" => "users#show"
  get "users/nouser" => "users#nouser"

  get "p/new" => "posts#new"
  post "p/new" => "posts#create"
  get "p/:id/edit" => "posts#edit"
  patch "p/:id/edit" => "posts#update"
  get "p/:id/destroy" => "posts#destroy"

  get "p/:id" => "posts#show"

  resources :users, param: :userid, path: "/", only: [:show]

  devise_for :users, :controllers => {
                       :omniauth_callbacks => "users/omniauth_callbacks",
                       :registrations => "users/registrations",
                       :sessions => "users/sessions",
                     }

  devise_scope :user do
    get "sign_up", :to => "users/registrations#new"
    get "sign_in", :to => "users/sessions#new"
    get "sign_out", :to => "users/sessions#destroy"
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
