class Notifier
  def new_message(message, params)
    pusher('message', {message: message.to_json}, params[:socketid])

    users = User.where(notify_me: true).ne(id: message.user.id, email: nil)
    users.each do |recipient|
      token = ReplyToken.create(message: message, user: recipient)

      if Rails.env.test?
        Notifications.new_message(message, recipient.email, token.token).deliver
      else
        EMAIL_QUEUE.push({message: message, email: recipient.email, token: token.token})
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
      unless Rails.env.test?
        if defined?(EventMachine) && EventMachine.reactor_running?
          Rails.logger.info "Pusher async trigger"
          Pusher['private-main'].trigger_async(type, message, socket)
        else
          Rails.logger.info "Pusher blocking trigger"
          PUSHER_QUEUE.push({type: type, message: message, socket: socket})
        end
      end
    end
end
