Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  resources :channels do
    member do
      post :leave
    end
  end
  
  root to: "channels#index"

  resources :messages, only: [:create]
end
