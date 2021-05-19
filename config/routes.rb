Rails.application.routes.draw do
  root 'users#new'
  resources :users, only: [:index, :new, :create, :edit, :update, :show]
  resources :sessions, only: [:new, :create, :destroy]
  resources :blogs do
    collection do
      post :confirm
    end
    member do
      patch :confirm
    end
  end
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  resources :favorites, only: [:create, :destroy, :show]
end
