Rails.application.routes.draw do
  resources :admins
  get 'sessions/new'
  resources :logins
  resources :students do
  collection do
    get 'mybooks'
    get 'allbooks'
    get 'logout'
    get 'viewbookmark'
  end
end
  resources :users
  resources :sign_up

  resources :librarians
  resources :books do
    collection do
      get 'book_bookmark'
    end
  end
  resources :libraries
  get 'approval_requests' => 'librarians#approval_requests'
  resources :librarians
  get 'checkout' => 'books#checkout'
  get 'destroy' => 'books#destroy'
  resources :books

  root 'logins#new'
  get 'students/alllibs' => 'students#alllibs'
  get 'students/viewbooks' => 'students#allbooks'
  get 'students/bookmarks' => 'students#bookmark'
  get 'students/fines' => 'students#fines'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
