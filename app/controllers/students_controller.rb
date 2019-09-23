class StudentsController < ApplicationController
  
  def student_params
    params.require(:student).permit(:name, :email, :password, :password_confirmation, :educational_level, :university, :maximum_book_limit)
  end

  def index

  end

  def show
    @student = Student.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @student }
    end
  end

  def new

    @student = Student.new
    respond_to do |format|
      format.html
      format.json{ render json: @student}
    end
  end

  def create
  	@student = Student.new(student_params)
    if params[:student][:educational_level]=="Undergraduate"
    	@student[:maximum_book_limit] = 2
    elsif params[:student][:educational_level]=="graduate"
    	@student[:maximum_book_limit] = 4
    elsif params[:student][:educational_level]=="phd"
    	@student[:maximum_book_limit] = 6
    end
    respond_to do |format|
      if @student.save
        #redirect_to controller: 'session', action: 'create', email: @student[:email]
        format.html { redirect_to @student }
        format.json { render json: @student, status: :created, location: @student }
      else
        format.html { render action: "new" }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

end
