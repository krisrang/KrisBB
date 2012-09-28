require "spec_helper"
require 'pry'

describe Notifications do
  describe "new_message" do
    let(:recipient) { create(:user).email }
    let(:message) { create(:message) }
    let(:mail) { Notifications.new_message(message, recipient) }

    it "renders the headers" do
      mail.should have_subject("New message")
      mail.should deliver_to(recipient)
      mail.should deliver_from("krisbb@kristjanrang.eu")
    end

    it "renders the body" do
      mail.should have_body_text("New message")
    end
  end
end
