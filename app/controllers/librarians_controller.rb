class LibrariansController < ApplicationController
  private

  def librarian_params
    params.require(:librarian).permit(:name, :email, :password, :password_confirmation, :libr, :library_id)

  end

  public

  def index
    if session[:role] != 'librarian'
      flash[:notice] = "login to access Account "
      redirect_to root_url
    end
  end

  def new
    if session[:role] != 'librarian'
      flash[:notice] = "login to access Account "
      redirect_to root_url
    else
      @librarian = Librarian.new
      @library = Library.all
      respond_to do |format|
        format.html
        format.json { render json: @librarian }
      end
    end
  end


  def create
    if session[:role] != 'librarian'
      flash[:notice] = "login to access Account "
      redirect_to root_url
    else
      @library = Library.find_by_library_id(params[:libr])
      params = librarian_params
      params[:library_id] = @library.id
      @librarian = Librarian.new(params)

      student = Student.find_by_email(@librarian[:email])

      if student == nil
        if @librarian.save
          puts session[:admin_id]
          if (session[:admin_id] != nil)
            redirect_to :controller => "admins", :action => "index"
          else
            redirect_to root_path, notice: "Librarian created successfully"
          end
        else
          render "librarians/new"
        end

      else

        redirect_to root_path, notice: "Account already created as Student"
      end
    end
  end

  def edit
    if session[:role] != 'librarian'
      flash[:notice] = "login to access Account "
      redirect_to root_url
    else
      @librarian = Librarian.find(session[:librarian_id])
    end
  end

  def update
    if session[:role] != 'librarian'
      flash[:notice] = "login to access Account "
      redirect_to root_url
    else
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
  end

  def add_book
    if session[:role] != 'librarian'
      flash[:notice] = "login to access Account "
      redirect_to root_url
    else
      redirect_to :controller => 'books', :action => 'new'
    end
  end

  def approval_requests
    if session[:role] != 'librarian'
      flash[:notice] = "login to access Account "
      redirect_to root_url
    else
      @holds = Transaction.where(["status = ? and library_id = ?", "approval request", session[:library]])
    end
  end

  def update_approval
    if session[:role] != 'librarian'
      flash[:notice] = "login to access Account "
      redirect_to root_url
    else
      @hold = Transaction.find_by_id(params[:id])
      @type = params[:request]
      if @type == 'approve'
        @hold.update_attribute(:status, "checked out")
        @book = Book.find_by_ISBN(@hold[:ISBN])
        copies = @book[:copies]
        @book.update_attribute(:copies, (copies.to_i - 1).to_s)
      else
        @hold.update_attribute(:status, "rejected")

      end
      redirect_to :controller => 'librarians', :action => 'approval_requests'
    end
  end

  def checked_out_books
    if session[:role] != 'librarian'
      flash[:notice] = "login to access Account "
      redirect_to root_url
    else
      @holds = Transaction.where(
          ["status = ? and library_id = ?", "checked out", session[:library]])
      puts "*********** in else ************"
      puts @holds.inspect
    end
  end

  def book_history
    if session[:role] != 'librarian'
      flash[:notice] = "login to access Account "
      redirect_to root_url
    else
      @checked_out = Transaction.where(
          ["status = ? and library_id = ?", "checked out", session[:library]])
      @overdue = Transaction.where(["status = ? and library_id = ?",
                                    "overdue", session[:library]])
      @returned = Transaction.where(["status = ? and library_id = ?",
                                     "returned", session[:library]])
      @library = Library.find_by_library_id(session[:library])
      @fine = @library[:fines]
    end
  end

end
