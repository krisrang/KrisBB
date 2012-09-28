class Notifications < ActionMailer::Base
  helper :application
  default from: "krisbb@kristjanrang.eu"

  def new_message(message, to)
    @message = message
    mail from: "krisbb@kristjanrang.eu",
         subject: "New message",
         to: to,
         reply_to: "#{message.id}.reply-message@krisbb.mailgun.org"
  end

  class Preview < MailView
    def new_message
      message = Message.last
      Notifications.new_message(message)
      # ::Notifier.invitation(inviter, invitee)  # May need to call with '::'
    end
  end
end
