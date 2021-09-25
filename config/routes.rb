Rails.application.routes.draw do
  get 'response_sets/index'
  get 'response_sets/edit'
  get 'response_sets/update'
  get 'answers/create'
  get 'questions/show'
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


  post "/friendships/accept", to: 'friendships#accept'
  get "/friendships/requests", to: 'friendships#requests'
  get "/friendships/search", to: 'friendships#search'

  resources :friendships, only: [:index, :show, :destroy, :create]

  resources :gift_sessions, only: [:new, :create, :show] do
    resources :gift_recommendations, only: [:index]
  end

  resources :questions, only: [:show]
  resources :answers, only: [:create, :edit, :update]
  resources :response_sets, only: [:index]
end
