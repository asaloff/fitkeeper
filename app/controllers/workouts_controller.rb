class WorkoutsController < ApplicationController
  before_action :require_user
  before_action :find_workout, only: [:show, :edit, :update, :destroy]

  def index
    @workouts = current_user.workouts
  end

  def show
  end

  def new
    @workout = Workout.new
  end

  def create
    @workout = Workout.new(workout_params)
    @workout.user_id = current_user.id

    if @workout.save
      put_exercises_into_workout
      flash["notice"] = "You've successfully added #{@workout.name.titleize}."
      redirect_to workouts_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @workout.update_attributes(workout_params)
      put_exercises_into_workout
      flash["notice"] = "#{@workout.name.titleize} was edited successfully"
      redirect_to workouts_path
    else
      render :edit
    end
  end

  def destroy
    @workout.destroy
    redirect_to workouts_path
  end

  private

  def workout_params
    params.require(:workout).permit(:name, :exercise_ids => [])
  end

  def find_workout
    @workout = Workout.find params[:id]
  end

  def put_exercises_into_workout
    @workout.exercises.clear
    params[:workout][:exercises].reject(&:empty?).each do |exercise_id|
      exercise = Exercise.find exercise_id.to_i
      @workout.exercises << exercise
    end
  end
end