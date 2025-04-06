Rails.application.routes.draw do
  devise_for :admins, path: "admin", skip: [ :registrations ]

  namespace :admin_panel, path: "admin" do
    root to: "dashboard#index"

    resources :dashboard, only: [ :index ]
    resources :administrators, only: [ :index ]
    resources :users, only: [ :index, :show ] do
      get :posts, on: :member
    end
    resources :posts, only: [ :index, :show, :edit, :update, :destroy ]

    resource :app_settings, only: [ :edit, :update ]
  end

  devise_for :users

  get "up", to: "rails/health#show", as: :rails_health_check
  get "service-worker", to: "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest", to: "rails/pwa#manifest", as: :pwa_manifest

  root "pages#home"

  resources :posts, only: [ :index, :show ] do
    resources :comments, only: [ :create, :destroy ], shallow: true
  end

  resources :users, only: [ :show, :edit, :update, :index ] do
    member do
      get :following
      get :followers
    end

    resources :relationships, only: [ :create, :destroy ]

    resources :posts, only: [ :index, :show, :new, :create, :edit, :update, :destroy ] do
      collection do
        get :sort
      end
      resources :comments, only: [ :create, :destroy ], shallow: true
    end
  end

  resources :notifications, only: [ :index, :show ]

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
