Rails.application.routes.draw do
  # Devise routes for user authentication
  devise_for :users

  # Health check route
  get "up", to: "rails/health#show", as: :rails_health_check

  # Routes for PWA files
  get "service-worker", to: "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest", to: "rails/pwa#manifest", as: :pwa_manifest


  resources :users do
    resources :posts
  end


  # Root path
  root "pages#home"

  # User routes with nested relationships
  resources :users, only: [:show, :edit, :update, :index] do
    member do
      get :following
      get :followers
    end

    resources :relationships, only: [:create, :destroy]
  end
end
