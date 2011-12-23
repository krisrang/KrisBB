class UsersController < ApplicationController
  load_and_authorize_resource except: :show

  layout 'form'

  def index
    #@users = User.all

    render json: @users 
  end

  def show
    #@user = User.find(params[:id])
    if params[:id] == "me" # ObjectID
      @user = current_user
    else
      @user = User.find(params[:id])
    end

    authorize! :show, @user
    render json: @user
  end

  def new
    #@user = User.new

    respond_to do |format|
      format.html
      format.json { render json: @new }
    end
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

    respond_to do |format|
      if @user.update_attributes(params[:upload])
        render json: @user, status: :ok
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end
  end

  def destroy
    #@user = User.find(params[:id])
    @user.destroy

    render json: @user, status: :ok
  end
end
