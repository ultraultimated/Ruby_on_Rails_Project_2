class BooksController < ApplicationController
  private

  def book_params
    params.require(:book).permit(:ISBN, :title, :author, :language,
                                  :published, :edition, :image, :subject,
                                  :summary, :specialcollection, :library, :copies)
  end

  public
  def show
    @book = Book.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @book }
    end
  end


  def new
    @book = Book.new

    respond_to do |format|
      format.html
      format.json { render json: @book }
    end
  end

  def create
    @book = Book.new(book_params)
    uploaded_to = params[:book][:image_url]
    @book[:library_id] = session[:library]
    params[:book][:specialcollection] = params[:specialcollection]

    @book[:image] = "asofnow"

    respond_to do |format|
      if @book.save
        format.html { redirect_to :controller => 'librarians', :action => 'index' }
        flash[:notice] = "Book Added successfully"

      else
        flash[:notice] = "Book not added.. please try again!"
        format.html { render action: "new" }
      end
    end
  end
end
