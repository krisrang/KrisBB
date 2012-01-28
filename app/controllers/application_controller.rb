class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied, with: :render_unauthorized

  protect_from_forgery

  private
    def not_authenticated
      redirect_to login_url, alert: "This page requires logging in."
    end

    def require_admin
      !!current_user && current_user.admin
    end

    def login_api
      authenticate_with_http_basic do |username, password|
        @current_user = User.authenticate(username, password)
        auto_login(@current_user) if @current_user
        @current_user
      end
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
end
