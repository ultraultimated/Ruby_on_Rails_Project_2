Rails.application.routes.draw do
  resources :students
  get 'sessions/new'
  resources :users
  resource :session
  root 'users#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
