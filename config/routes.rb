Rails.application.routes.draw do
  resources :libraries
  resources :books
  get 'sessions/new'
  resources :logins
  resources :students do
  collection do
    get 'mybooks'
    get 'allbooks'
    get 'logout'
  end
end
  resources :users
  resource :session
  resources :sign_up
  resources :librarians do
    collection do
      post 'add_book'
    end
  end
  root 'logins#new'
  get 'students/alllibs' => 'students#alllibs'
  get 'students/viewbooks' => 'students#allbooks'
  get 'students/bookmarks' => 'students#bookmark'
  get 'students/fines' => 'students#fines'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
