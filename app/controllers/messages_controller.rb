class MessagesController < ApplicationController
  respond_to :html, :json
  
  def index
    @messages = Message.all
    respond_with @messages
  end

  def show
    @message = Message.find(params[:id])
    respond_with @message
  end

  def new
    @message = Message.new
    respond_with @message
  end
  
  def edit
    @message = Message.find(params[:id])
  end

  def create
    @message = Message.new(params[:message])
    @message.save
    respond_with @message
  end

  def update
    @message = Message.find(params[:id])
    @message.update_attributes(params[:message])
    respond_with @message
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    head :ok
  end
end
