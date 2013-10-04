Anonymail::Application.routes.draw do

  root 'home#index'

  namespace :users do
    
    resources :dashboard, :only => [:index]

  end

  namespace :api do
  
    resources :mail

  end

  devise_for :user

end
