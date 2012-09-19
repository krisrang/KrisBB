class MessagesController < ApplicationController
  layout 'bb', only: ['bb']
  load_and_authorize_resource

  respond_to :json, :html, only: [:bb, :index]
  respond_to :json

  # Main app
  def bb
    @messages = @messages.list.limit(30)
    respond_with @messages
  end

  # Archive
  def index
    @messages = @messages.list.page(params[:page] || 1)
    respond_with @messages
  end

  def show
    #@message = Message.find(params[:id])
    respond_with @message
  end

  def create
    params[:message].delete(["html", "user", "created_at"])
    
    #@message = Message.new(params[:message])
    @message.user = current_user
    
    if @message.save
      notifier.new_message(@message, params)
    end

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
