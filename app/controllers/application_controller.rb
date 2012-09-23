class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied, with: :render_unauthorized

  before_filter :login_api

  protect_from_forgery

  private
    def notifier
      @notifier ||= Notifier.new
    end

    def not_authenticated
      redirect_to login_path, alert: "This page requires logging in."
    end

    def login_api
      if request.format.json? && !logged_in?
        # Authorization: Token token="abc", nonce="def"
        authenticate_or_request_with_http_token do |token, options|
          begin
            @current_user = User.find_by(token: token)
            auto_login(@current_user) if @current_user
            @current_user
          rescue Mongoid::Errors::DocumentNotFound => e
            render_unauthorized e
          end
        end
      else
        true
      end
    end

    def render_unauthorized(e=nil)
      respond_to do |format|
        format.html { not_authenticated }
        format.json { render json: { error: "Unauthorized" }, status: 401 }
      end
    end
end
