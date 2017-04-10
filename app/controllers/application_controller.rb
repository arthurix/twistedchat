class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  helper_method :current_user, :logged_in?
  before_action :register_user


  def current_user
    @current_user ||= session[:username] if session[:username]
  end

  def logged_in?
    !!current_user
  end

  protected

  def authenticate_user!
    redirect_to login_path unless logged_in?
  end

  def register_user
    username = current_user
    ActionCable.server.broadcast 'users',
                                 user: current_user,
                                 username: current_user
  end
end
