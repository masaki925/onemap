class ApplicationController < ActionController::Base
  protect_from_forgery

  def require_authentication
    unless current_user
      session[:redirect_to] = request.url
      redirect_to root_path, notice: 'please login to use this application'
    end
  end
end
