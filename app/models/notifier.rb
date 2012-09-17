class Notifier
  def new_message(message, params)
    begin
      Pusher['main'].trigger_async('message', {message: message.to_json}, params[:socketid])
    rescue
      Pusher['main'].trigger('message', {message: message.to_json}, params[:socketid])
    end
  end
end
