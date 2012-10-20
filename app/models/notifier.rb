class Notifier
  def new_message(message, params)
    pusher('message', {message: message.to_json}, params[:socketid])

    users = User.where(notify_me: true).ne(id: message.user.id, email: nil)
    users.each do |recipient|
      token = ReplyToken.create(message: message, user: recipient)
      EMAIL_QUEUE.push({message: message, email: recipient.email, token: token.token})
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
      Rails.logger.info "Pusher blocking trigger"
      PUSHER_QUEUE.push({type: type, message: message, socket: socket})
    end
end
