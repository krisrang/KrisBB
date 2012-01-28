class SessionsController < ApplicationController
  before_filter :login_api, only: [:mobile_login]

  layout 'form'

  def new
    @user = User.new
  end
  
  def create
    user = login(params[:user][:username], params[:user][:password], params[:user][:remember_me])

    if user
      redirect_back_or_to root_url, notice: "Logged in!"
    else
      @user = User.new(params[:user])
      flash.now.alert = "Username or password was invalid"
      render :new
    end
  end
  
  def destroy
    logout
    redirect_to root_url, notice: "Logged out!"
  end

  def mobile_login
    render json: current_user
  end
end
