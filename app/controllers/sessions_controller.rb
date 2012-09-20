class SessionsController < ApplicationController
  layout 'form'

  protect_from_forgery except: [:create_token]
  skip_before_filter :login_api, only: [:create_token]

  def new
    @user = User.new
  end

  def create
    user = login(params[:user][:username], params[:user][:password], params[:user][:remember_me])

    if user
      redirect_back_or_to root_path
    else
      @user = User.new(params[:user])
      render :new, alert: "Username or password was invalid"
    end
  end

  def create_token
    user = User.authenticate(params[:login] || "", params[:password] || "")

    if user
      render json: user.to_json(include: [:token])
    else
      render_unauthorized
    end
  end

  def destroy
    logout
    redirect_to root_path
  end
end
