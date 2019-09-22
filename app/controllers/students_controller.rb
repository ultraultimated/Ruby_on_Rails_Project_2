class StudentsController < ApplicationController
  
  def student_params
    params.require(:student).permit(:name, :email, :password, :password_confirmation, :educational_level, :university, :maximum_book_limit)
  end

 #  wrap_parameters :student, include: [:name, :email, :password, :password_confirmation, :educational_level, :university]
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
  	puts "******"
    if params[:educational_level]=="Undergraduate"
    	puts "inside ******************************"
    	@student[:maximum_book_limit] = 2
    end
	
    respond_to do |format|
      if @student.save
        format.html { redirect_to @student, notice: 'Student was successfully signed up.' }
        format.json { render json: @student, status: :created, location: @student }
      else
        format.html { render action: "new" }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

end
