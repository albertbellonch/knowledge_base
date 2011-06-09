KnowledgeBase::Application.routes.draw do
  devise_for :users, :controllers => {:registrations => 'registrations', :sessions => "sessions"}
  resources :facts, :except => :index do
    resources :comments
  end

  resources :tags, :only => [:create, :destroy]

  resources :authentications, :only => :destroy
  match '/auth/:provider/callback' => 'authentications#create'

  match "/feed" => "static#feed"
  root :to => 'facts#index'
end
