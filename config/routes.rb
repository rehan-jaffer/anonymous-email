Anonymail::Application.routes.draw do

  root 'home#index'

  namespace :users do
    
    resources :dashboard, :only => [:index]
    resources :mail

  end

  namespace :api do
  
    resources :account, :only => [:index]
    resources :tokens, :only => [:create, :destroy]
    resources :mail, :only => [:create]
    resources :users do
      resources :mail
      resources :mailbox
    end
    devise_for :user, :module => "devise", :controllers => { :sessions => "api/sessions" }

  end

end
