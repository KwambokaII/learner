class Api::V1::CoursesController < ApplicationController
    #  before_action :authenticate_user!
    before_action :set_course, only: [:show, :update, :destroy, :send_reminder]
  
    def index
      @courses = Course.all
      render json: @courses
    end
  
    def show
      render json: @course
    end
  
    def create
    #   @course = current_user.courses.build(course_params)
      @course = Course.new(course_params)
    #   @course.teacher_id = current_user.id
      if @course.save
        render json: @course, status: :created
      else
        render json: @course.errors, status: :unprocessable_entity
      end
    end
  
    def update
      if @course.update(course_params)
        render json: @course
      else
        render json: @course.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @course.destroy
      head :no_content
    end
  
    def send_reminder
        ReminderJob.perform_later(@course)
        render json: { message: 'Reminder sent' }
    end
  
    private
  
    def set_course
      @course = Course.find(params[:id])
    end
  
    def course_params
      params.require(:course).permit(:title, :description)
    end
  end