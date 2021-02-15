Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do
    resources :subs, only: [:create, :edit]
  end
  resource :session
  resources :subs, except: [:destroy, :create, :edit] do
    resources :posts, except: [:index]
  end
end
