class LibrariansController < ApplicationController
  private

  def librarian_params
    params.require(:librarian).permit(:name, :email, :password, :password_confirmation, :libr, :library)

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
    end
  end


  def show

  end

  def create
    @librarian = Librarian.new(librarian_params)
    @librarian[:library] = params[:libr]

    student = Student.find_by_email(@librarian[:email])
    respond_to do |format|
      if student == nil
        ######

        if @librarian.save
          puts "*****"
          format.html { redirect_to root_path, notice: "Librarian created successfully" }
        else
          render "librarians/new"
        end

      else

        redirect_to root_path, notice: "Account already created as Student"
      end
    end
  end

  def edit
    @librarian = Librarian.find(session[:librarian_id])
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

  def editlib

  end


end
