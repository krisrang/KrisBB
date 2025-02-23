class MessagesController < ApplicationController
  layout 'bb', only: ['bb']
  load_and_authorize_resource except: [:from_email]

  skip_before_filter :verify_authenticity_token, only: [:from_email]

  respond_to :json, :html

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
    respond_with @message
  end

  def from_email
    unless params["recipient"].blank? || params["stripped-text"].blank?
      token = params["recipient"].gsub(".reply-message@krisbb.mailgun.org", "")
      text = params["stripped-text"]

      begin
        replytoken = ReplyToken.find_by(token: token)
        message = Message.new(user: replytoken.user, text: text)
        notifier.new_message(message, params) if message.save
      rescue Mongoid::Errors::DocumentNotFound
      end
    end

    render text: "OK"
  end

  def create
    params[:message].delete(["html", "user", "created_at"])
    @message.user = current_user

    if @message.save
      notifier.new_message(@message, params)
    end

    respond_with @message
  end

  def update
    @message.update_attributes(params[:message])
    respond_with @message
  end

  def destroy
    @message.destroy

    notifier.delete_message(@message)
    respond_to do |format|
      format.html { redirect_to messages_path }
      format.json { respond_with @message }
    end
  end
end
