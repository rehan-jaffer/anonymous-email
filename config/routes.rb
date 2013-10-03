Anonymail::Application.routes.draw do

  root 'home#index'

  namespace :api do
  
    resources :mail

  end

  devise_for :user

end
