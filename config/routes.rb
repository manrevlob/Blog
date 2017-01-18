Rails.application.routes.draw do

  devise_for :users
  root 'welcome#index'

  # CRUD Articles
  resources :articles
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
