Rails.application.routes.draw do
  resources :users, only: [:index, :show] do
    resources :purchases, only: [:index, :show]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
