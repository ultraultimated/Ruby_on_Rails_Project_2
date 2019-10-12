class AdminsController < ApplicationController
  private
  def admin_params
    params.require(:admin).permit(:name, :email, :password, :password_confirmation, :educational_level, :university_id, :maximum_book_limit, :libr, :library_id )
  end

  public

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
      @student = Student.all
    end
end
  
  #To show the list of all librarians
   def showalllibrarians
    if !session[:admin_id]
      flash[:notice] = "Login to access Account "
      redirect_to root_url
    else
      @librarian = Librarian.all
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
      puts params[:student_id]
      @student = Student.find_by_id(params[:student_id])
    end
  end


  def editlibrarian
      if !session[:admin_id]
        flash[:notice] = "Login to access Account "
        redirect_to root_url
      else
        @librarian = Librarian.find_by_librarian_id(params[:librarian_id])
      end
  end


  def destroy
    reset_session
    redirect_to root_url
    flash[:notice]="Logged out successfully."
  end

  def all_books
    if session[:role] != 'admin'
      redirect_to root_url
      flash[:notice] = "Login to access Account "
    else
      @books = Book.all
      puts @books.inspect
    end
  end

  def approve_librarian
    if session[:role] != 'admin'
      redirect_to root_url
      flash[:notice] = "Login to access Account "
    else
      @requests = Librarian.where(:is_valid => "requested")
    end
  end  

  def update_approval_librarian
    if session[:role] != 'admin'
      flash[:notice] = "login to access Account "
      redirect_to root_url
    else
      @librarian = Librarian.find_by_librarian_id(params[:id])
      @type = params[:request]
      if @type == 'approve'
        @librarian.update_attribute(:is_valid, "approved")

      else
        @librarian.delete
      end
      redirect_to :controller => "admins", :action => "approve_librarian"
    end
  end

  def deletestudent
    @student = Student.find_by_id(params[:student_id])
    @student.delete
    @tr = Transaction.where('student_id = '+params[:student_id])
    @tr.each do |t|
      @bk = Book.find_by_ISBN(t.ISBN)
      c = @bk[:copies]
      @bk.update_attribute(:copies, (c.to_i + 1).to_s)
    end
    Transaction.where('student_id = '+params[:student_id]).delete_all
    Hold.where('student_id = '+params[:student_id]).delete_all
    Bookmark.where('student_id = '+params[:student_id]).delete_all
    redirect_to :controller => "admins", :action => "showallstudents"
  end

  def deletelibrarian
    @librarian = Librarian.find(params[:librarian_id])
    @librarian.delete
    flash[:notice]="Librarian account was successfully deleted."
    redirect_to :controller => "admins", :action => "showalllibrarians"
  end
end