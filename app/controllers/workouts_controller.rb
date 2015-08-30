class WorkoutsController < ApplicationController
  before_action :require_user

  def index
    @workouts = current_user.workouts
  end

  def show
    @workout = Workout.find params[:id]
  end

  def new
    @workout = Workout.new
  end

  def create
    @workout = Workout.new(workout_params)
    @workout.user_id = current_user.id

    if @workout.save
      params[:workout][:exercises].reject(&:empty?).each do |exercise_id|
        exercise = Exercise.find exercise_id.to_i
        @workout.exercises << exercise
      end

      flash["notice"] = "You've successfully added #{@workout.name.titleize}."
      redirect_to workouts_path
    else
      render :new
    end
  end

  private

  def workout_params
    params.require(:workout).permit(:name, :exercise_ids => [])
  end
end