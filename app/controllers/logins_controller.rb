class LoginsController < ApplicationController
  private

  def login_params
    params.require(:login).permit(:email, :password)
  end

  public

  def new
    @login = Login.new
  end

  def create
    @login = Login.new(login_params)
    student = Student.find_by_email(@login[:email])
    if student&.authenticate(params[:login][:password])
      session[:student_id] = student.id
      session[:role] = "student"
      redirect_to :controller => 'students', :action => 'index'
    else
      librarian = Librarian.find_by_email(@login[:email])
      if librarian&.authenticate(params[:login][:password])
        session[:librarian_id] = librarian.id
        session[:role] = "librarian"
        session[:library] = ""
        redirect_to :controller => 'librarians', :action => 'index'
      else
        flash[:notice] = "Invalid Credentials"
        redirect_to root_path
      end
    end
  end

   def destroy
    # Remove the user id from the session
    if session[:student_id]
      session[:student_id] = nil
    elsif session[:librarian_id]
      session[:librarian_id] = nil
    end
    redirect_to root_url
  end
end