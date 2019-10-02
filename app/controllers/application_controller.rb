class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


def user_is_logged_in?
	if !session[:student_id] and !session[:librarian_id]
		return false
	else
		return true
  end


end
end