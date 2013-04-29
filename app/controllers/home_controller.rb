class HomeController < ApplicationController
  def index
  end
  def logout
    reset_session
    redirect_to root_url, :notice => "Logged out!"
  end
end
