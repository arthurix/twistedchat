class UsersController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :verify_authenticity_token, only: [:destroy]

  def new
  end

  def create
    @user = User.new(user_params)
    if login
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

  private
  def login
      session[:username] = @user.username if @user.valid?
    end

    def user_params
      params.require(:user).permit(:username)
    end
end
