Rails.application.routes.draw do

  resources :categories
  root 'welcome#index'
  resources :articles do
    resources :comments, only: [:create, :destroy, :update]
  end

  devise_for :users

  get "/dashboard", to: "welcome#dashboard"
  put "/articles/:id/publish", to: "articles#publish"

  #get '/articles',              to: 'articles#index'
  #get '/articles/:id',          to: 'articles#show'
  #get '/articles/new',          to: 'articles#new'

=begin
  #get "/articles" index
  #post "/articles" create
  #delete "/articles:id" destroy
  #get "/articles/:id" show
  #get "/articles/new" new
  #get "/articles/:id/edit" edit
  #patch "/articles/:id" update
  #put "/articles/:id" update
=end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
