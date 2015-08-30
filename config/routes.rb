Rails.application.routes.draw do
  root to: 'workouts#index'
  get 'ui(/:action)', controller: 'ui'

  get '/home', to: 'workouts#index'

  get '/register', to: 'users#new'

  resources :users, only: [:create]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  get '/workout_complete', to: 'pages#workout_complete'
  get '/exercise_created_success', to: 'pages#exercise_created_success'
  get '/exercise_required', to: 'pages#exercise_required'

  resources :exercises do
    collection do
      post :update_multiple
    end
  end

  resources :workouts
end
