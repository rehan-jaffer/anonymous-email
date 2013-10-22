Anonymail::Application.routes.draw do

  root 'demo#index'

  resource :demo

  namespace :users do
    
    resources :dashboard, :only => [:index]
    resources :mail

  end

  namespace :api do

    namespace :mail do
  
    resources :reports
    resources :account, :only => [:index]
    resources :tokens, :only => [:create, :destroy]
#    resources :mail, :only => [:create]
    resources :mailbox
    resources :entry, :only => [:create, :show]
    devise_for :user, :module => "devise", :controllers => { :sessions => "api/mail/sessions", :registrations => "api/mail/registrations" }

    resources :users do
    end

    end

  end

end
