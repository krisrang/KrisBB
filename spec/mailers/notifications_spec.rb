require "spec_helper"

describe Notifications do
  describe "new_message" do
    let(:message) { create(:message) }
    let(:mail) { Notifications.new_message(message) }

    it "renders the headers" do
      recipients = []
      2.times { recipients << create(:user) }

      mail.subject.should eq("New message")
      mail.should bcc_to(recipients)
      mail.from.should eq(["krisbb@kristjanrang.eu"])
    end

    it "renders the body" do
      mail.body.encoded.should match("New message")
    end
  end
end
