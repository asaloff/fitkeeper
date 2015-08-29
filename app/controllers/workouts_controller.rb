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
end