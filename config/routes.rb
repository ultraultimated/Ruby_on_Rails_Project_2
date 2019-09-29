Rails.application.routes.draw do
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
      get 'editlib'
    end
  end
  resources :books do
  collection do
    get 'checkout'
  end
end

  root 'logins#new'
  get 'students/alllibs' => 'students#alllibs'
  get 'students/viewbooks' => 'students#allbooks'
  get 'students/bookmarks' => 'students#bookmark'
  get 'students/fines' => 'students#fines'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
