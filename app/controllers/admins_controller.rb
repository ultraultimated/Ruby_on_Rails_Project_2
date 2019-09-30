class AdminsController < ApplicationController
   private

  def admin_params
    params.require(:admin).permit(:name, :email, :password, :password_confirmation)

  end

  public

  def index

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
    if !session[:student_id]
      flash[:notice] = "login to access Account "
      redirect_to root_url
    else
    @admin = Admin.find(session[:admin_id])
    end
  end

  def update
    @librarian = Librarian.find(params[:id])
    respond_to do |format|
      if @librarian.update_attributes(librarian_params)
        format.html { redirect_to :controller => 'librarians', :action => 'index' }
        flash[:notice] = "Librarian Info was successfully updated."
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @librarian.errors, status: :unprocessable_entity }
      end
    end
  end

  def add_book
    redirect_to :controller => 'books', :action => 'new'
  end

  def view_all

  end

end

  