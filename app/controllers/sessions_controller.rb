class SessionsController < ApplicationController
  def new
    redirect_to home_path if current_user
  end

  def create
    user = User.find_by username: params[:username]

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to home_path
    else
      flash['danger'] = 'There was something wrong with your username or password.'
      redirect_to login_path
    end 
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end
end