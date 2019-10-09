class LibrariansController < ApplicationController
  private

  def librarian_params
    params.require(:librarian).permit(:name, :email, :password, :password_confirmation, :libr, :library_id, :is_valid)

  end

  public

  def index
    if session[:role] != 'librarian'
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
    end

  end

  def show
  end


  def create

    @library = Library.find_by_library_id(params[:libr])
    params = librarian_params
    params[:library_id] = @library.id
    @librarian = Librarian.new(params)
    @librarian[:is_valid] = "requested"

    student = Student.find_by_email(@librarian[:email])

    if student == nil
      if @librarian.save
        if session[:role] != 'admin'
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

  def edit
    if session[:role] != 'librarian'
      flash[:notice] = "login to access Account "
      redirect_to root_url
    else
      @librarian = Librarian.find(session[:librarian_id])
    end
  end

  def update
    if session[:role] != 'admin' and session[:role] != 'librarian'
      flash[:notice] = "login to access Account "
      redirect_to root_url
    else
      @librarian = Librarian.find(params[:id])
      puts params.inspect
      @librarian[:library_id] = params[:libr]
      respond_to do |format|
        if @librarian.update_attributes(librarian_params)
          if session[:role] == 'admin'
            format.html { redirect_to :controller => 'admins', :action => 'showalllibrarians' }
          else
            format.html { redirect_to :controller => 'librarians', :action => 'index' }
          end
          flash[:notice] = "Librarian info was successfully updated."
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
      puts @holds.inspect
    end
  end

  def update_approval
    if session[:role] != 'librarian'
      flash[:notice] = "login to access Account "
      redirect_to root_url
    else
      @hold = Transaction.find_by_id(params[:id])
      @student = Student.find_by_id(@hold[:student_id])
      @type = params[:request]
      if @type == 'approve'
        LibrarianMailer.confirm_book(@student).deliver_now
        @hold.update_attribute(:status, "checked out")
        @hold.update_attribute(:checkout_date, Date.today)
        @library = Library.find_by_library_id(@hold[:library_id])
        @hold.update_attribute(:expected_date, Date.today +
            @library[:max_days].to_i.days)
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
    if session[:role] != 'librarian' and session[:role] != 'admin'
      flash[:notice] = "login to access Account "
      redirect_to root_url
    elsif session[:role] == 'librarian'
      @holds = Transaction.where(
          ["status = ? and library_id = ?", "checked out", session[:library]])
    else
      @holds = Transaction.where(:status => "checked out")


    end
  end

  def book_history
    if session[:role] != 'librarian' and session[:role] != 'admin'
      flash[:notice] = "login to access Account "
      redirect_to root_url
    elsif session[:role] == 'librarian'
      @checked_out = Transaction.where(
          ["status = ? and library_id = ?", "checked out", session[:library]])
      @overdue = Transaction.where(["status = ? and library_id = ?",
                                    "overdue", session[:library]])
      @returned = Transaction.where(["status = ? and library_id = ?",
                                     "returned", session[:library]])
      @library = Library.find_by_library_id(session[:library])
      @rejected = Transaction.where(["status = ? and library_id = ?",
                                     "rejected", session[:library]])
      @fine = @library[:fines]
    else
      @checked_out = Transaction.where(
          :status => "checked out")
      @overdue = Transaction.where(:status => "overdue")
      @returned = Transaction.where(:status => "returned")
      @rejected = Transaction.where(:status => "rejected")
    end
  end

  def view_hold_requests
    if session[:role] != 'librarian' and session[:role] != 'admin'
      flash[:notice] = "login to access Account "
      redirect_to root_url
    elsif session[:role] == 'admin'
      @holds = Hold.all
    else
      @holds = Hold.where(:library_id => session[:library])
    end
  end

  def overdue
    if session[:role] != 'librarian' and session[:role] != 'admin'
      flash[:notice] = "login to access Account "
      redirect_to root_url
    elsif session[:role] == 'admin'
      @overdue = Transaction.where(:status => 'overdue')
    else
      @overdue = Transaction.where(["status = ? and library_id = ?",
                                    "overdue", session[:library]])
    end

  end

  def dest
    flash[:notice] = "Logged out successfully"
    reset_session
    redirect_to root_url
  end
end