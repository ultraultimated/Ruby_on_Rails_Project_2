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
      session[:university_id] = student.university_id
      redirect_to :controller => 'students', :action => 'index'
    elsif Librarian.find_by_email(@login[:email])
      librarian = Librarian.find_by_email(@login[:email])
      if librarian&.authenticate(params[:login][:password])
        if librarian.is_valid == 'requested'
          flash[:notice] = "Your request is still in queue"
          redirect_to root_path
        else
          session[:librarian_id] = librarian.id
          session[:role] = "librarian"
          session[:library] = librarian[:library_id]
          session[:status] = librarian.is_valid
          redirect_to :controller => 'librarians', :action => 'index'
        end
      else
        flash[:notice] = "Invalid Credentials"
        redirect_to root_path
      end
    elsif Admin.find_by_email(@login[:email])
      admin = Admin.find_by_email(@login[:email])
      if admin&.authenticate(params[:login][:password])
        session[:admin_id] = admin.id
        session[:role] = "admin"
        redirect_to :controller => 'admins', :action => 'index'
      else
        flash[:notice] = "Invalid Credentials"
        redirect_to root_path
      end
    else
      flash[:notice] = "Invalid Credentials"
      redirect_to root_path
    end
  end

  def destroy
    # Remove the user id from the session
    if session[:student_id]
      session[:student_id] = nil
    elsif session[:librarian_id]
      session[:librarian_id] = nil
    elsif session[:admin_id]
      session[:admin_id] = nil
    end
    redirect_to root_url
  end
end
