class StudentsController < ApplicationController
  
  def student_params
    params.require(:student).permit(:name, :email, :password, :password_confirmation, :educational_level, :university, :maximum_book_limit)
  end
#<% if !session[:student_id] 
#  redirect_to root_url end%>

  def index
    if !session[:student_id]
      flash[:notice] = "login to access Account "
      redirect_to root_url
    end
  end

  def show
    if !session[:student_id]
      flash[:notice] = "login to access Account "
      redirect_to root_url
    else
    @student = Student.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @student }
      end
    end
  end

  def new
    if !session[:student_id]
      flash[:notice] = "login to access Account "
      redirect_to root_url
    else
    @student = Student.new
    respond_to do |format|
      format.html
      format.json{ render json: @student}
    end
  end
  end

  def create
    if !session[:student_id]
      flash[:notice] = "login to access Account "
      redirect_to root_url
    else
  	@student = Student.new(student_params)
    ####to find if user is already librarian
    librarian = Librarian.find_by_email(@student[:email])
    if librarian == nil
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
    else
         flash[:notice] = "Account already created as librarian"
         redirect_to root_path
    end
  end
   end

 def update
    if !session[:student_id]
      flash[:notice] = "login to access Account "
      redirect_to root_url
    else
    @student = Student.find(params[:id])

    respond_to do |format|
      #format.html { redirect_to @student, notice: 'Student Info was successfully updated.' }
      #, 
      if @student.update_attributes(student_params)
        format.html { redirect_to :controller => 'students', :action => 'index', notice: 'Student Info was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end
  end

  def edit
    if !session[:student_id]
      flash[:notice] = "login to access Account "
      redirect_to root_url
  else
    @student = Student.find(session[:student_id])
      end
  end

  def mybooks
    if !session[:student_id]
      flash[:notice] = "login to access Account "
      redirect_to root_url
    else
    @librarian = Librarian.all
  end
  end


  def allbooks
    if !session[:student_id]
      flash[:notice] = "login to access Account "
      redirect_to root_url
    end
  end

  def bookmark
    if !session[:student_id]
      flash[:notice] = "login to access Account "
      redirect_to root_url
    end
  end 

  def fines
    if !session[:student_id]
      flash[:notice] = "login to access Account "
      redirect_to root_url
    end
  end

  def logout
    reset_session
    redirect_to root_url
  end


end
