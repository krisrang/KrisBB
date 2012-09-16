class MessagesController < ApplicationController
  layout 'bb', only: ['bb']
  load_and_authorize_resource

  respond_to :json, :html, only: [:bb, :index]
  respond_to :json

  # Main app
  def bb
    @messages = @messages.index.limit(30)
  end

  # Archive
  def index
    @messages = @messages.index.page(params[:page] || 1)
  end

  def show
    #@message = Message.find(params[:id])
    respond_with @message
  end

  def create
    #@message = Message.new(params[:message])
    @message.user = current_user
    @message.save

    begin
      Pusher['main'].trigger_async('message', {message: @message.to_json}, params[:socketid])
    rescue
      Pusher['main'].trigger('message', {message: @message.to_json}, params[:socketid])
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
