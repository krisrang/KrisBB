class Notifier
  def self.new_message(message, params)
    begin
      Pusher['main'].trigger_async('message', {message: message.to_json}, params[:socketid])
    rescue
      Pusher['main'].trigger('message', {message: message.to_json}, params[:socketid])
    end
  end

  def self.update_user(user)
    begin
      Pusher['main'].trigger_async('user', {user: user.to_json})
    rescue
      Pusher['main'].trigger('user', {user: user.to_json})
    end
  end
end
