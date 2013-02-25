Swcsurfcamp::Application.routes.draw do

  get "welcome/index"

  resources :reservations

  root :to => 'welcome#index'

  resources :pages, only: [:new, :create]

  #keep these at the bottom of your file. They should be the last routes.
  get "/:slug", to: "pages#show", as: :slug
  get "/:slug/edit", to: "pages#edit", as: :edit_slug
  put "/:slug", to: "pages#update", as: :slug
  post "/:slug", to: "pages#destroy", as: :slug
end
