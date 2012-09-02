class MessagesController < ApplicationController
  layout 'bb', only: ['bb']
  load_and_authorize_resource
  respond_to :json

  # Main app
  def bb
    @messages = @messages.includes(:user).desc(:created_at).limit(30)
    respond_with @messages do |format|
      format.html { render }
    end
  end

  # Archive
  def index
    @messages = @messages.includes(:user).desc(:created_at)
    @messages = @messages.page(params[:page] || 1)

    respond_with @messages do |format|
      format.html { render }
    end
  end

  def show
    #@message = Message.find(params[:id])
    respond_with @message
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
