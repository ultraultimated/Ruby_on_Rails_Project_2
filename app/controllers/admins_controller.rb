class AdminsController < ApplicationController
   private

  def admin_params
    params.require(:admin).permit(:name, :email, :password, :password_confirmation, :educational_level, :university_id, :maximum_book_limit )
  end

  public

  def index
    if !session[:admin_id]
      flash[:notice] = "login to access Account "
      redirect_to root_url
    end
  end

  
  def showallstudents
    if !session[:admin_id]
      flash[:notice] = "Login to access Account "
      redirect_to root_url
    else
      @student=Student.all
    end
end
  
   def showalllibrarians
    if !session[:admin_id]
      flash[:notice] = "Login to access Account "
      redirect_to root_url
    else
      @librarian=Librarian.all
    end
end

  
  def edit
    if !session[:admin_id]
      flash[:notice] = "login to access Account "
      redirect_to root_url
    else
    @admin = Admin.find(session[:admin_id])
    end
  end

  def update
    if !session[:admin_id]
      flash[:notice] = "login to access Account "
      redirect_to root_url
    else
    @admin = Admin.find(params[:id])
    respond_to do |format|
      #format.html { redirect_to @student, notice: 'Student Info was successfully updated.' }
      #, 
      if @admin.update_attributes(admin_params)
        format.html { redirect_to :controller => 'admins', :action => 'index', notice: 'Admin Info was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end
  end

  def updatestudent
    if !session[:admin_id]
      flash[:notice] = "login to access Account "
      redirect_to root_url
    else
      @student = Student.find(params[:id])

    respond_to do |format|
      #format.html { redirect_to @student, notice: 'Student Info was successfully updated.' }
      #, 
      if @student.update_attributes(student_params)
        format.html { redirect_to :controller => 'admins', :action => 'showallstudents', notice: 'Student Info was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end
  end

  def editstudent
    if !session[:admin_id]
      flash[:notice] = "login to access Account "
      redirect_to root_url
  else
    @student = Student.find([:student_id])
      end
  end

  def editlibrary
  end

  def updatelibrary
  end

  def logout
    reset_session
    redirect_to root_url
  end
end

  