class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  include ApplicationHelper

  def logged_in?
    !!current_user
  end

  def redirect_logged_in?
    redirect_to messages_path and return if logged_in?
  end

  protected

  def authenticate_user!
    redirect_to login_path and return unless logged_in?
  end
end
