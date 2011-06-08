KnowledgeBase::Application.routes.draw do
  resources :authentications
  match '/auth/:provider/callback' => 'authentications#create'

  devise_for :users, :controllers => {:registrations => 'registrations', :sessions => "sessions"}
  resources :facts do
    resources :comments
  end

  resources :tags, :only => [:create, :destroy]

  #match "/rss" => "static#rss"
  root :to => 'static#index'
end
