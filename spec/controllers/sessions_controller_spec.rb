require 'spec_helper'

describe SessionsController do
  before do
    @user = create(:user, password: "secret")
  end

  describe "GET #ping" do
    it "sends empty 200" do
      get :ping
      response.response_code.should eq(200)
      response.body.should eq("")
    end
  end

  describe "POST #login_token" do
    it "sends token on valid user" do
      post :login_token, login: @user.username, password: "secret"
      response.body.should have_content(@user.token)
    end

    it "returns unauthorized on invalid user" do
      post :login_token, format: :json
      response.response_code.should eq(401)
    end
  end

  describe "POST #pusher" do
    it "authenticates logged in user" do
      login_user @user
      post :pusher, channel_name: "private-main", socket_id: "test"
      response.body.should have_content("auth")
    end

    it "returns unauthorized on invalid user" do
      post :pusher, format: :json
      response.response_code.should eq(401)
    end
  end
end

