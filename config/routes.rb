Rails.application.routes.draw do
  # ✅ Devise rute za administratore (bez registracije)
  devise_for :admins, path: "admin", skip: [:registrations]
  
  namespace :admin_panel, path: "admin" do
    root to: "dashboard#index"
    resources :dashboard, only: [:index]
    resources :administrators, only: [:index]
    resources :users, only: [:index, :show] do
      get :posts, on: :member
    end
    resources :posts, only: [:index, :show]
  end
  
  

  # ✅ Devise rute za obične korisnike
  devise_for :users

  # ✅ Health check ruta
  get "up", to: "rails/health#show", as: :rails_health_check

  # ✅ Routes za PWA
  get "service-worker", to: "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest", to: "rails/pwa#manifest", as: :pwa_manifest

  # ✅ Root path
  root "pages#home"

  # ✅ Global posts routes
  resources :posts, only: [:index, :show] do
    resources :comments, only: [:create, :destroy], shallow: true
  end

  # ✅ User routes
  resources :users, only: [:show, :edit, :update, :index] do
    member do
      get :following
      get :followers
    end

    resources :relationships, only: [:create, :destroy]
    
    resources :posts, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
      collection do
        get :sort # Route for sorting posts
      end
      resources :comments, only: [:create, :destroy], shallow: true
    end
  end

  # ✅ Notifications routes
  resources :notifications, only: [:index, :show]

  # ✅ LetterOpener za razvoj
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
