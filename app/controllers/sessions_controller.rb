class SessionsController < ApplicationController
  def new
  end

  def create
  	student = Student.find_by(email: params[:email])
    if student&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to student_path, notice: 'Logged in!'
    else
      flash.now.alert = 'Email or password is invalid'
      render :new
    end
  end

end
