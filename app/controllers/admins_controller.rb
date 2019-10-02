class AdminsController < ApplicationController
   private

  def admin_params
    params.require(:admin).permit(:name, :email, :password, :password_confirmation, :educational_level, :university_id, :maximum_book_limit, :libr, :library_id )
  end

  public
#Home Page
  def index
    if !session[:admin_id]
      flash[:notice] = "Login to access Account "
      redirect_to root_url
    end
  end

  # To show the list of students
  def showallstudents
    if !session[:admin_id]
      flash[:notice] = "Login to access Account "
      redirect_to root_url
    else
      @student=Student.all
    end
end
  
  #To show the list of all librarians
   def showalllibrarians
    if !session[:admin_id]
      flash[:notice] = "Login to access Account "
      redirect_to root_url
    else
      @librarian=Librarian.all
    end
end

# To edit admin info  
  def edit
    if !session[:admin_id]
      flash[:notice] = "Login to access Account "
      redirect_to root_url
    else
    @admin = Admin.find(session[:admin_id])
    end
  end

  #To reflect the edited changes in the database
  def update
    if !session[:admin_id]
      flash[:notice] = "Login to access Account "
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


#To update student in the database
  def editstudent
    if !session[:admin_id]
      flash[:notice] = "Login to access Account "
      redirect_to root_url
  else
    @student = Student.find_by_id(params[:student_id])
    end
  end

  def editlibrarian
      if !session[:admin_id]
      flash[:notice] = "Login to access Account "
      redirect_to root_url
  else
    @librarian = Librarian.find_by(params[:librarian_id])
    end
  end


  def logout
    reset_session
    redirect_to root_url
  end
  def all_books
    @books = Book.all
    puts @books.inspect
  end



end

  