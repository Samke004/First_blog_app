Rails.application.routes.draw do
  get "notifications/index"
  get "notifications/show"
  # Devise routes for user authentication
  devise_for :users

  # Health check route
  get "up", to: "rails/health#show", as: :rails_health_check

  # Routes for PWA files
  get "service-worker", to: "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest", to: "rails/pwa#manifest", as: :pwa_manifest

  # Root path
  root "pages#home"

  # Global posts routes
resources :posts, only: [:index, :show] do
  # Comments nested under posts
  resources :comments, only: [:create, :destroy], shallow: true
end

# User-specific routes
resources :users, only: [:show, :edit, :update, :index] do
  # Routes for following and followers
  member do
    get :following
    get :followers
  end

  # Relationships nested under users
  resources :relationships, only: [:create, :destroy]

  # Nested routes for user-specific posts
  resources :posts, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    collection do
      get :sort # Route for sorting posts
    end

    # Comments nested under user-specific posts
    resources :comments, only: [:create, :destroy], shallow: true
  end
end

# Notifications routes
resources :notifications, only: [:index, :show]

end