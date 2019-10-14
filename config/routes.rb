Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'tests#index'

  get :login, to: 'sessions#new'
  delete :logout, to: 'sessions#destroy'

  resources :sessions, only: :create
  resources :users, only: %i[new create]

  resources :tests do
    resources :questions, shallow: true, except: :index do
      resources :answers, shallow: true, except: :index
    end

    member do
      post :start
    end
  end

  resources :passing_tests, only: %i[show update] do
    member do
      get :result
    end
  end
end
