class ApplicationController < ActionController::Base
  protect_from_forgery

  def not_authenticated
    redirect_to login_url, alert: "This page requires logging in."
  end

  def require_admin
    !!current_user && current_user.admin
  end
end
