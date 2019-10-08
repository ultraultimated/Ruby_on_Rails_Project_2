Rails.application.routes.draw do
  get 'librarians/dest' => 'librarians#dest'
  get 'all_books' => 'admins#all_books'
  get 'approve_librarian' => 'admins#approve_librarian'
  get 'update_approval_librarian' => 'admins#update_approval_librarian'
  resources :admins do
   collection do
    get 'destroy'
    get 'createstudent'
    get 'showallstudents'
    get 'showalllibrarians'
    get 'editstudent'
    get 'editlibrarian'
    get 'deletestudent'
    get 'deletelibrarian'
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
    get 'fines'
    get 'returns'
    get 'approval_requests'
    get 'cancelrequest'
  end
end
  resources :sign_up
  resources :books do
    collection do
      get 'book_bookmark'
      get 'search'
      get 'showimage'
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
  resources :librarians do
    collection do
=begin
      get 'approval_requests'
      get 'update_approval'
      get 'checked_out_books'
      get 'book_history'
      get 'view_hold_requests'
      get 'overdue'
      get 'signout'
=end

    end
  end


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
