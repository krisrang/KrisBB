class MessagesController < ApplicationController
  layout 'bb', only: ['bb']
  load_and_authorize_resource
  respond_to :html, :json

  # Main app
  def bb
    @messages = @messages.includes(:user).desc(:created_at).limit(50)
    respond_with @messages
  end

  # Archive
  def index
    @messages = @messages.includes(:user).desc(:created_at)
    @messages = @messages.page(params[:page] || 1)

    respond_with @messages
  end

  def show
    #@message = Message.find(params[:id])
    respond_with @message
  end

  def new
    #@message = Message.new
    respond_with @message
  end

  def edit
    #@message = Message.find(params[:id])
  end

  def create
    #@message = Message.new(params[:message])
    @message.user = current_user
    @message.save

    respond_with @message
  end

  def update
    #@message = Message.find(params[:id])
    @message.update_attributes(params[:message])
    respond_with @message
  end

  def destroy
    #@message = Message.find(params[:id])
    @message.destroy
    #head :ok
    respond_with @message
  end
end
