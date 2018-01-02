Rails.application.routes.draw do
  get 'sessions/new'

  root 'static_pages#home'
  get  '/contact', to: 'static_pages#contact'
  get '/signup',  to: 'users#new'
  post '/signup', to: 'users#create'

  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"

  get 'tags/:tag', to: 'static_pages#home', as: :tag

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

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
