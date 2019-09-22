class LibrariansController < ApplicationController
  private

  def librarian_params
    params.require(:librarian).permit(:name, :email, :password, :password_confirmation, :library)

  end

  public

  def new
    puts "**************in librarian"
    @librarian = Librarian.new
    puts @librarian == nil
    respond_to do |format|
      format.html
      format.json { render json: @librarian }
    end
  end

  def create
    @librarian = Librarian.new(librarian_params)
    if @librarian.save
      flash[:notice] = "Librarian created successfully"
      redirect_to root_path
    else
      render "librarians/new"
    end

  end

end
