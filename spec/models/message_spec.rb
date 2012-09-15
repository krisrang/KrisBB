require 'spec_helper'

describe Message do
  it { should belong_to (:user) }
  it { should_not allow_mass_assignment_of(:html) }
  it { should validate_presence_of(:text) }

  describe ".smilies" do
    it "returns registered smilies" do
      expect(Message.smilies).to include(":(" => "frown")
    end
  end

  describe ".recent" do
    it "includes only 5 recent messages" do
      messages = []
      5.times { messages << create(:message) }
      expect(Message.recent.reverse).to eq(messages)
    end
  end

  describe ".as_json" do
    it "includes the user record" do
      message = create(:message)
      json = JSON.parse(message.to_json)
      json["user"]["_id"].should eq(message.user.id.to_s)
    end
  end

  describe ".save" do
    it "processes text to html converting newlines" do
      message = create(:message)
      text = "test"
      html = "<p>test</p>\n"
      message.text = text
      message.save
      message.html.should eq(html)
    end

    it "parses smilies in the text" do
      message = create(:message)
      text = ":)"
      html = "<p><i class=\"smilie smilies-smile\"></i></p>\n"
      message.text = text
      message.save
      message.html.should eq(html)
    end
  end
end
