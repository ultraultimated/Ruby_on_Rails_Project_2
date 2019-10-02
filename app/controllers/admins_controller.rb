class AdminsController < ApplicationController
   private

  def admin_params
    params.require(:admin).permit(:name, :email, :password, :password_confirmation)

  end

  public

  def index
    if !session[:admin_id]
      flash[:notice] = "login to access Account "
      redirect_to root_url
    end
  end

  def new
    @librarian = Librarian.new
    @library = Library.all
    respond_to do |format|
      format.html
      format.json { render json: @librarian }
      format.json {render json: @student}
    end
  end


  def show
    @student=Student.all
    @library=Library.all
    respond_to do |format|
      format.html
      format.json { render json: @librarian }
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

  def logout
    reset_session
    redirect_to root_url
  end

  def add_book
    redirect_to :controller => 'books', :action => 'new'
  end

  def view_all

  end

  def all_books
    @books = Book.all
    puts @books.inspect
  end



end

  