class MessagesController < ApplicationController
  load_and_authorize_resource
  respond_to :html, :json

  def index
    @message = Message.new
    @messages = @messages.includes(:user)

    if params[:page]
      @messages = @messages.page params[:page]
    else
      @messages = @messages.desc(:created_at).limit(50)
    end

    respond_with @messages
  end

  def show
    #@message = Message.find(params[:id])
    respond_with @message do |format|
      format.html { redirect_to root_path }
    end
  end

  def new
    #@message = Message.new
    respond_with @message do |format|
      format.html { redirect_to root_path }
    end
  end

  def edit
    #@message = Message.find(params[:id])
  end

  def create
    #@message = Message.new(params[:message])
    @message.user = current_user
    @message.save

    respond_with @message do |format|
      format.html { redirect_to root_path }
    end
  end

  def update
    #@message = Message.find(params[:id])
    @message.update_attributes(params[:message])
    respond_with @message do |format|
      format.html { redirect_to root_path }
    end
  end

  def destroy
    #@message = Message.find(params[:id])
    @message.destroy
    #head :ok
    respond_with @message do |format|
      format.html { redirect_to root_path }
    end
  end
end
