Rails.application.routes.draw do
  get 'all_books' => 'admins#all_books'
  get 'approve_librarian' => 'admins#approve_librarian'
  get 'update_approval_librarian' => 'admins#update_approval_librarian'
  get 'deletestudent' => 'admins#deletestudent'
  resources :admins do
   collection do
    get 'logout'
    get 'createstudent'
    get 'showallstudents'
    get 'showalllibrarians'
    get 'editstudent'
    get 'editlibrarian'
  end
end

  get 'sessions/new'
  resources :logins
  resources :students do
  collection do
    get 'mybooks'
    get 'allbooks'
    get 'logout'
    get 'viewbookmark'
    get 'alllibs'
  end
end
  resources :sign_up
  resources :books do
    collection do
      get 'book_bookmark'
      get 'search'
    end
  end
  resources :libraries
  get 'approval_requests' => 'librarians#approval_requests'
  get 'update_approval' => 'librarians#update_approval'
  get 'checked_out_books' => 'librarians#checked_out_books'
  get 'book_history' => 'librarians#book_history'
  get 'view_hold_requests' => 'librarians#view_hold_requests'
  get 'overdue' => 'librarians#overdue'
  get 'signout' => 'librarians#signout'
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
