Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do
    resources :subs, only: [:create, :edit]
  end

  resources :subs, only: [:index, :show, :update, :destroy] do
    resources :posts, only: [:create]
  end

  resources :posts, only: [:show, :new, :edit, :update, :destroy]

  resource :session, only: [:new, :create, :destroy]
end
