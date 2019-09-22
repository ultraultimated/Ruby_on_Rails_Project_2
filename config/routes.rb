Rails.application.routes.draw do
  resources :logins
  resources :students
  resources :users
  resource :session
  resources :sign_up
  resources :librarians
  root 'logins#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
