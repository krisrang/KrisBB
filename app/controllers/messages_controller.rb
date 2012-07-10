class MessagesController < ApplicationController
  load_and_authorize_resource
  respond_to :html, :json

  def index
    if params[:page]
      @messages = @messages.page params[:page]
    else
      @messages = @messages.desc(:created_at).limit(50).reverse
    end

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
