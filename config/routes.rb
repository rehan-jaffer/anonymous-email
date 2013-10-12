Anonymail::Application.routes.draw do

  root 'demo#index'

  resource :demo

  namespace :users do
    
    resources :dashboard, :only => [:index]
    resources :mail

  end

  namespace :api do
  
    resources :reports
    resources :account, :only => [:index]
    resources :tokens, :only => [:create, :destroy]
    resources :mail, :only => [:create]
    resources :mailbox
    resources :mail
    resources :users do
    end
    devise_for :user, :module => "devise", :controllers => { :sessions => "api/sessions" }

  end

end
