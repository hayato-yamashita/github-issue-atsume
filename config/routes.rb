Rails.application.routes.draw do
  root 'github/repositories#index'

  namespace :github do
    resources :repositories, only: [:index, :show, :new, :create, :destroy] do
      member do
        post :fetch
      end
    end
  end
end
