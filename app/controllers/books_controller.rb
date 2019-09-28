class BooksController < ApplicationController
  private

  def book_params
    params.require(:book).require(:ISBN, :title, :author, :language,
                                  :published, :edition, :image_url, :subject,
                                  :summary, :special_collection)
  end

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
    @book = Book.new
    uploaded_to = params[:book][:image_url]
    respond_to do |format|
      if @book.save
        format.html { redirect_to @book }
        flash[:notice] = "Book Added successfully"
      else
        flash[:notice] = "Book not added.. please try again!"
        format.html { render action: "new" }
      end


    end
  end
end
