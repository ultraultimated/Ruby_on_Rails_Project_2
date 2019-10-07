class LibrariesController < ApplicationController
  private

  def library_params
    params.require(:library).permit(:name, :location, :fines, :max_days, :university_id)

  end

  public

  def index
    @library = Library.where(university_id:  session[:university_id])
  end


  def edit
    if session[:role] != 'librarian'
      flash[:notice] = "login to access Account "
      redirect_to root_url
    else
      @library = Library.find_by_library_id(session[:library])
      @university = University.find_by_university_id(@library[:university_id])
    end
  end

  def update
    if session[:role] != 'librarian'
      flash[:notice] = "login to access Account "
      redirect_to root_url
    else
      @library = Library.find_by_library_id(params[:id])
      params = library_params
      params[:university_id] = @library[:university_id]
      respond_to do |format|

        if @library.update_attributes(params)
          format.html { redirect_to :controller => 'librarians', :action => 'index' }
          flash[:notice] = "Library Info was successfully updated."
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @library.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def new
    @library = Library.new
  end

  def create
    if session[:role] != 'admin'
      flash[:notice] = "login to access Account "
      redirect_to root_url
    else
      @library = Library.new(library_params)
      @library[:university_id] = params[:university_id]
      if @library.save
        flash[:notice] = "Library created successfully"
        redirect_to :controller => "admins", :action => "index"
      else
        render 'libraries/new'
      end
    end
  end


end
