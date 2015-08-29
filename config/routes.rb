Rails.application.routes.draw do
  root to: 'exercises#index'
  get 'ui(/:action)', controller: 'ui'

  get '/home', to: 'exercises#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  get '/workout_complete', to: 'pages#workout_complete'
  get '/exercise_created_success', to: 'pages#exercise_created_success'

  resources :exercises do
    collection do
      post :update_multiple
    end
  end

  resources :workouts
  # , :index, :show, :edit, :update
end
