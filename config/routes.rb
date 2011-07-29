KnowledgeBase::Application.routes.draw do
  devise_for :users, :controllers => {:registrations => 'registrations', :sessions => "sessions"}

  # Administration
  namespace :admin do
    resources :facts, :only => [:index, :update, :destroy]
    resources :categories, :only => [:index, :create, :update, :destroy]

    root :to => "overview#index"
  end

  resources :facts, :except => :index do
    get :autocomplete_tag_name, :on => :collection
    resources :comments
  end

  resources :tags, :only => [:create, :destroy]

  resources :authentications, :only => :destroy
  match '/auth/:provider/callback' => 'authentications#create'

  match "/feed" => "static#feed"
  match "/(:page)" => "facts#index", :as => :root
end
