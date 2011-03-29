KnowledgeBase::Application.routes.draw do
  resources :authentications
  match '/auth/:provider/callback' => 'authentications#create'

  devise_for :users, :controllers => {:registrations => 'registrations'}
  resources :facts, :except => :index do
    resources :comments
  end

  resources :tags

  root :to => 'facts#index'
end
