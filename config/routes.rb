Swcsurfcamp::Application.routes.draw do

  get "welcome/index"
  get "paypal_express/checkout"
  get "paypal_express/review"
  get "paypal_express/purchase"
  get "log_in" => "sessions#new", as: "log_in"
  get "log_out" => "sessions#destroy", as: "log_out"

  resources :reservations
  resources :camps
  resources :pages, only: [:new, :create]
  resources :sessions

  root :to => 'welcome#index'

  #keep these at the bottom of your file. They should be the last routes.
  get "/:slug", to: "pages#show", as: :slug
  get "/:slug/edit", to: "pages#edit", as: :edit_slug
  put "/:slug", to: "pages#update", as: :slug
  post "/:slug", to: "pages#destroy", as: :slug
end
