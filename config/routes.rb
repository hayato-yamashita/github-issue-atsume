Rails.application.routes.draw do
  root 'github/repositories#index'

  namespace :github do
    resources :repositories, only: [:index, :new, :create, :destroy]
  end
end
