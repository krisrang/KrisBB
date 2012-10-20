class Notifications < ActionMailer::Base
  helper :application
  default from: "krisbb@kristjanrang.eu"

  def new_message(message, to, token)
    @message = message
    mail from: "krisbb@kristjanrang.eu",
         subject: "New message",
         to: to,
         reply_to: "#{token}.reply-message@krisbb.mailgun.org"
  end

  # :nocov:
  class Preview < MailView
    def new_message
      message = Message.last
      user = User.last
      token = ReplyToken.create(message: message, user: user)
      Notifications.new_message(message, user.email, token.token)
      # ::Notifier.invitation(inviter, invitee)  # May need to call with '::'
    end
  end
  # :nocov:
end
