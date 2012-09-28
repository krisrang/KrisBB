class Notifier
  def new_message(message, params)
    pusher('message', {message: message.to_json}, params[:socketid])

    users = User.where(notify_me: true).ne(id: message.user.id)
    if users
      users.each do |recipient|
        token = ReplyToken.create(message: message, user: recipient)
        Notifications.new_message(message, recipient.email, token.token).deliver
      end
    end
  end

  def delete_message(message)
    pusher('delete', {id: message.id})
  end

  def update_user(user)
    pusher('user', {user: user.to_json})
  end

  protected
    def pusher(type, message, socket = nil)
      begin
        Pusher['main'].trigger_async(type, message, socket)
      rescue
        Pusher['main'].trigger(type, message, socket)
      end
    end
end
