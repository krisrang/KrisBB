class Notifications < ActionMailer::Base
  default from: "krisbb@kristjanrang.eu"

  def new_message(message)
    @message = message
    users = User.where(notify_me: true).ne(id: message.user.id)
    if users
      recipients = users.map(&:email)
      mail subject: "New message", bcc: recipients
    end
  end
end
