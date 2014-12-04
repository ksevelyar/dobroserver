Dobroserver::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  get  "contact" => "contact#new"
  post "contact" => "contact#create"

  get "/feed" => "posts#feed", :as => :feed, :format => "atom"
  get "/ksevelyar" => "pages#show", :as => "show", :id => "ksevelyar"

  resources :pages do
    resources :images
    resources :attachments
  end

  resources :posts, only: [:index, :show], path: "" do
    resources :comments
    resources :images
    resources :attachments

    get "page-:page", action: :index, on: :collection
  end

  resources :tags, only: :show do
    get ":id/page-:page", action: :show, on: :collection
  end

  root to: "posts#index"
end
