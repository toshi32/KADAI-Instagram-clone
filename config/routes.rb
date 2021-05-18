Rails.application.routes.draw do
  get 'sessions/new'
  get 'users/new'
  get 'users/show'
  get 'blogs/index'
  get 'blogs/new'
  get 'blogs/confirm'
  get 'blogs/edit'
  get 'blogs/show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
