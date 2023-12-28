Rails.application.routes.draw do
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  resources :players, only: [:new, :create, :index]
  resources :teams, only: [:new, :create, :index, :show]
  resources :tournaments, only: [:create, :show, :index] do
    post 'seed_teams', on: :member
    post 'seed_matches', on: :member
    get 'participation', on: :member
    post 'participate', on: :member
  end
  get "/assign", to: "players#assign", as: :assign
  post 'assign_team', to: 'players#assign_team'
  get '/tournaments/:id/result', to: 'tournaments#result', as: 'tournament_result'

  resources :projects, only: [:new, :create, :index, :show] do
    resources :tasks, only: [:index, :new, :create, :show] do
      patch :assign_user, on: :member
      patch :set_status, on: :member
    end
  end
end
