class LibrariansController < ApplicationController
  private

  def librarian_params
    params.require(:librarian).permit(:name, :email, :password, :password_confirmation, :library)

  end

  public

  def index

  end

  def new
    @librarian = Librarian.new
    respond_to do |format|
      format.html
      format.json { render json: @librarian }
    end
  end

  def create
    @librarian = Librarian.new(librarian_params)
    ####to find if user is already student
    student = Student.find_by_email(@librarian[:email])
    if student == nil
            ######
          if @librarian.save
            redirect_to root_path, notice: "Librarian created successfully"
          else
            render "librarians/new"
          end
    else 

      redirect_to root_path, notice: "Account already created as Student"
    end
  end

end
