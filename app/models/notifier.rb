class Notifier
  def new_message(message, params)
    send('message', {message: message.to_json}, params[:socketid])
  end

  def update_user(user)
    send('user', {user: user.to_json})
  end

  protected
    def send(type, message, socket = nil)
      begin
        Pusher['main'].trigger_async(type, message, socket)
      rescue
        Pusher['main'].trigger(type, message, socket)
      end
    end
end
