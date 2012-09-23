class Notifier
  def new_message(message, params)
    pusher('message', {message: message.to_json}, params[:socketid])
    Notifications.new_message(message).deliver
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
