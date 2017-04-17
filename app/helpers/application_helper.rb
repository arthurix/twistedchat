module ApplicationHelper
  def current_user
    @current_user ||= session[:username] if session[:username]
  end

  def current_dialect
    @current_dialect ||= session[:dialect] if session[:dialect]
  end
end
