Anonymail::Application.routes.draw do

  root 'home#index'

  namespace :api do
  
    resources :mail

  end

end
