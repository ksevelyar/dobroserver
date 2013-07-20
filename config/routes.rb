Dobroserver::Application.routes.draw do
  get  "contact" => "contact#new"
  post "contact" => "contact#create"

  get "/feed" => "posts#feed", :as => :feed, :format => "atom"
  get "/ksevelyar" => "pages#show", :as => "show", :id => "ksevelyar"

  #resources :admin

  resources :sessions, only: [:new, :create, :destroy]

  resources :pages do
    resources :images
    resources :attachments
  end

  resources :posts, path: "" do
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
