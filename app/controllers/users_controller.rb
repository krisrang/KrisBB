class UsersController < ApplicationController
  load_and_authorize_resource
  respond_to :html, :json
  layout 'form', only: [:new, :create]

  def index
    #@users = User.all
    respond_with @users
  end

  def show
    #@user = User.find(params[:id])
    respond_with @user
  end

  def new
    #@user = User.new
    respond_with @user
  end

  def edit
    #@user = User.find(params[:id])
    respond_with @user
  end

  def create
    #@user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        auto_login(@user, params[:user][:remember_me])
        format.html { redirect_to root_url, notice: "Signed up!" }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    #@user = User.find(params[:id])

    if params[:user][:password] && params[:user][:password].empty?
      params[:user].delete :password
      params[:user].delete :password_confirmation
    end

    respond_to do |format|
      if @user.update_attributes(params[:user])
        Notifier.update_user(@user)
        format.html { redirect_to root_url, notice: "Settings updated!" }
        format.json { render json: @user, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    #@user = User.find(params[:id])
    @user.destroy
    respond_with @user
  end
end
