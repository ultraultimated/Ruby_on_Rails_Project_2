class StudentsController < ApplicationController
  def new
    @student = Student.new
    respond_to do |format|
      format.html
      format.json{ render json: @student}
    end
  end
end
