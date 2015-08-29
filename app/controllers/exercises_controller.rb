class ExercisesController < ApplicationController
  before_action :require_user
  before_action :find_exercise, only: [:edit, :update, :destroy]
  
  def index
    @exercises = current_user.exercises
  end

  def new
    @exercise = Exercise.new
  end

  def create
    @exercise = Exercise.create(exercise_params)
    @exercise.user = current_user

    if @exercise.save
      redirect_to exercise_created_success_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @exercise.update_attributes(exercise_params) 
      flash["notice"] = @exercise.name.titleize + " was updated successfully"
      redirect_to home_path
    else
      render :edit
    end
  end

  def destroy
    @exercise.destroy
    redirect_to home_path
  end

  def update_multiple
    params[:exercises].each do |exercise_data|
      exercise = Exercise.find(exercise_data["id"])
      if exercise.user == current_user
        exercise.update_attributes!(weight: exercise_data["weight"], time: exercise_data["time"], sets: exercise_data["sets"], reps: exercise_data["reps"]) 
      end
    end

    redirect_to workout_complete_path
  end

  private

  def exercise_params
    params.require(:exercise).permit(:name, :weight, :time, :time_type, :sets, :reps, :user_id)
  end

  def find_exercise
    @exercise = Exercise.find params[:id]
  end
end
