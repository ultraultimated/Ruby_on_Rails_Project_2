class LibrariesController < ApplicationController
  private

  def library_params
    params.require(:library).permit(:name, :university, :location, :fines, :max_days)

  end

  public

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
      @library = Library.find(params[:id])
      @university = University.find_by_name(library_params[:university])
      params = library_params
      params[:university] = @university


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

end
