Rails.application.routes.draw do
  get '/all_purchases', to: 'purchases#all'
  resources :users, only: [:index, :show, :new, :create] do
    resources :purchases, only: [:index, :show, :new, :create]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
