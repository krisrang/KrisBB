class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied, with: :render_unauthorized

  protect_from_forgery

  before_filter :prepare_for_mobile

  private

  def not_authenticated
    redirect_to login_url, alert: "This page requires logging in."
  end

  def require_admin
    !!current_user && current_user.admin
  end

  def render_unauthorized e    
    respond_to do |format|
      format.html do
        if logged_in?
          redirect_to root_url, alert: "Cannot access specified resource"
        else
          require_login
        end
      end
      format.json { render json: { error: "Unauthorized" }, status: 403 }
    end
  end

  def mobile_device?
    if session[:mobile_param]
      session[:mobile_param] == "1"
    else
      request.user_agent =~ /Mobile|webOS/
    end
  end
  helper_method :mobile_device?

  def prepare_for_mobile
    session[:mobile_param] = params[:mobile] if params[:mobile]
    request.format = :mobile if mobile_device?
  end
end
