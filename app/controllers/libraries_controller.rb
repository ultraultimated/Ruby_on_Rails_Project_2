class LibrariesController < ApplicationController
  def show
    @library = Library.find_by_id(session[:library])
    puts @library[:university]

    @university = University.find_by_id(@library[:university])
  end
end
