class ApplicationController < ActionController::Base
  protect_from_forgery

  if Rails.env.production?
    http_basic_authenticate_with :name => ENV['BASIC_ID'], :password => ENV['BASIC_PASS']
  end

  def require_authentication
    unless current_user
      session[:redirect_to] = request.url
      redirect_to root_path, notice: 'please login to use this application'
    end
  end

  def http_referer_uri
    request.env["HTTP_REFERER"] && URI.parse(request.env["HTTP_REFERER"])
  end
end
