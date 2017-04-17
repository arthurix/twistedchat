class UsersController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :verify_authenticity_token, only: [:destroy]
  before_action :redirect_logged_in?, only: [:new]
  layout 'user'

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      create_session
      redirect_to messages_path, success: 'User was successfully logged in.'
    else
      flash.now[:alert] = @user.errors.full_messages.join(', ')
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end

  def create_session
    if @user.valid?
      session[:username] = @user.username
      session[:dialect] = @user.dialect
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :dialect, :status)
  end
end
