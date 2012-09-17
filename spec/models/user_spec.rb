require 'spec_helper'

describe User do
  it { should have_many (:messages) }
  it { should_not allow_mass_assignment_of(:admin) }
  it { should validate_presence_of(:username) }
  it { should validate_confirmation_of(:password) }
  it { should validate_length_of(:password) }

  describe ".as_json" do
    it "does not include sensitive fields" do
      user = create(:user)
      json = JSON.parse(user.to_json)

      ["password",
      "crypted_password",
      "salt",
      "token",
      "unlock_token",
      "lock_expires_at",
      "failed_logins_count",
      "remember_me_token",
      "remember_me_token_expires_at"].each do |field|
        json.should_not include(field)
      end
    end
  end

  describe "before_save" do
    it "makes certain all users have generated fields" do
      user = create(:user)
      user.token = user.colour = nil
      user.save
      user.token.should_not eq(nil)
      user.colour.should_not eq(nil)
    end
  end

  describe "before_create" do
    it "generates colour and token for the user" do
      user = create(:user, token: nil, colour: nil)
      user.token.should_not eq(nil)
      user.colour.should_not eq(nil)
    end
  end
end
