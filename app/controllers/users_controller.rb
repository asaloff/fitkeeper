class UsersController < ApplicationController
  before_action :send_user_home

  def new 
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash["notice"] = "Welcome #{current_user.full_name}! You've successfully registered."
      redirect_to home_path
    else
      render :new
    end
  end

  private

  def send_user_home
    redirect_to home_path if logged_in?
  end

  def user_params
    params.require(:user).permit(:full_name, :username, :password, :password_confirmation)
  end
end