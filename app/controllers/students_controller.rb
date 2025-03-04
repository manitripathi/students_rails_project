class StudentsController < ApplicationController
   # GET /students or /students.json
    def index
        @students = Student.all
    end

    def new
        # This action will show the create new student form
        @student = Student.new
    end

    def create
        # @student = Student.new(student_params) → Creates a new student with form data.
        @student = Student.new(student_params)
        if @student.save
            flash[:notice] = "✅ Student created successfully!"
            redirect_to '/students', notice: "Student created successfully!"
        else
            flash[:alert] = "❌ Error creating student!"
            render :new
        end
    end

    def show
        # Finds that student in the database.
        @student = Student.find(params[:id])
        # params[:id] → Gets the ID from the URL (e.g., /students/3).
    end

    def update
        @student = Student.find(params[:id])
        if @student.update(student_params)
            redirect_to '/students', notice: "Student updated successfully!"
        else
            render :edit
        end
    end

    def edit
        @student = Student.find(params[:id])
    end

    def destroy
        @student = Student.find(params[:id])
        if @student.destroy
          flash[:notice] = "✅ Student deleted successfully!"
          Rails.logger.debug "Student successfully deleted: #{@student.id}"
        else
          flash[:alert] = "❌ Error deleting student!"
          Rails.logger.debug "Failed to delete student: #{@student.errors.full_messages}"
        end
        redirect_to students_path, notice: "Student deleted successfully!"
    end
      

    def student_params
        # params.require(:student) ensure student key is present in the parameters.
        params.require(:student).permit(:first_name, :last_name, :email, :phone)
    end
end