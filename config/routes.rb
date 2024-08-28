Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }
  resources :posts do
    member do
      post 'like'
    end
  end

  # Defines the root path route ("/")
  root "posts#index"
end
