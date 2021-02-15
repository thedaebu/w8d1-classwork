Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do
    resources :subs, only: [:create]
    resources :posts, only: [:create]
  end
  resource :session
  resources :subs, except: [:destroy, :create]
  resources :posts, except: [:index, :create]

end
