class Notifications < ActionMailer::Base
  helper :application
  default from: "krisbb@kristjanrang.eu"

  def new_message(message)
    @message = message
    users = User.where(notify_me: true).ne(id: message.user.id)
    if users
      recipients = users.map(&:email)
      recipients.each do |rec|
        mail from: "krisbb@kristjanrang.eu",
             subject: "New message",
             to: rec,
             reply_to: "#{message.id}.reply-message@krisbb.mailgun.org"
      end
    else
      self.message.perform_deliveries = false
    end
  end

  class Preview < MailView
    def new_message
      message = Message.last
      Notifications.new_message(message)
      # ::Notifier.invitation(inviter, invitee)  # May need to call with '::'
    end
  end
end
