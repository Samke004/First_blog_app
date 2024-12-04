Rails.application.routes.draw do
  # Devise routes for user authentication
  devise_for :users

  # Health check route
  get "up", to: "rails/health#show", as: :rails_health_check

  # Routes for PWA files
  get "service-worker", to: "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest", to: "rails/pwa#manifest", as: :pwa_manifest

  # Posts routes (global)
  resources :posts, only: [:index, :show]

  # User routes
  resources :users, only: [:show, :edit, :update, :index] do
    # Nested posts routes
    resources :posts, only: [:index, :new, :create, :edit, :update, :destroy] do
      collection do
        get :sort # Route for sorting posts
      end
    end

    # Member routes for following and followers
    member do
      get :following
      get :followers
    end

    # Nested relationships routes
    resources :relationships, only: [:create, :destroy]
  end

  # Root path
  root "pages#home"
end
