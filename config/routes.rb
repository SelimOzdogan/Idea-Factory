Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "ideas#index"

  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]

  resources :ideas do
    resources :reviews, shallow: true, only: [:create, :destroy]
    resources :likes, shallow: true, only: [:create, :destroy]

  end
end
