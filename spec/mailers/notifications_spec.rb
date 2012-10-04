require "spec_helper"
require 'pry'

describe Notifications do
  describe "new_message" do
    let(:recipient) { create(:user).email }
    let(:message) { create(:message) }
    let(:token) { create(:reply_token, user: recipient, message: message) }
    let(:mail) { Notifications.new_message(message, recipient, token.token) }

    it "renders the headers" do
      mail.should have_subject("New message")
      mail.should deliver_to(recipient)
      mail.should reply_to("#{token.token}.reply-message@krisbb.mailgun.org")
      mail.should deliver_from("krisbb@kristjanrang.eu")
    end

    it "renders the body" do
      mail.should have_body_text(message.email_html)
    end
  end
end
