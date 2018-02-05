Rails.application.routes.draw do
  get 'sessions/new'

  get 'tags/:tag', to: 'todo_posts#home', as: :tag
  root 'todo_posts#home'

  get '/signup',  to: 'users#new'
  post '/signup', to: 'users#create'

  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"

  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]


  get '/', to: 'todo_posts#index'
  resources :todo_posts do
    member do
      patch :complete
    end
  end

  resources :advanced_searches

end
