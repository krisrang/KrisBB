class MessageMailer < ActionMailer::Base
  default from: "mail@kristjanrang.eu", to: "mail@kristjanrang.eu"
  
  def new_message(msg)
    @message = msg

    mail(subject: "New message")
  end
end