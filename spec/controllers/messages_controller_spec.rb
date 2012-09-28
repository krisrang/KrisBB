require 'spec_helper'

describe MessagesController do
  before do
    @user = create(:user)
  end

  def get_valid(action)
    request.env['HTTP_AUTHORIZATION'] = 
      ActionController::HttpAuthentication::Token.encode_credentials(@user.token)
    get action, format: :json
  end

  def get_invalid(action)
    request.env['HTTP_AUTHORIZATION'] = 'Token token=""'
    get action, format: :json
  end

  def post_email(token)
    data = YAML::load(File.open("#{Rails.root}/spec/fixtures/mailgun_email_post.yml"))
    post :from_email, data.merge({
      "recipient" => "#{token}.reply-message@krisbb.mailgun.org",
      "to" => "#{token}.reply-message@krisbb.mailgun.org",
      "To" => "#{token}.reply-message@krisbb.mailgun.org"})
  end

  describe "GET #index" do
    it "authenticates token" do
      get_valid :index
      assigns(:current_user).should eq(@user)
      response.response_code.should == 200
    end

    it "errors invalid token" do
      get_invalid :index
      response.response_code.should == 401
    end
  end

  describe "POST #from_email" do
    before do
      @token = create(:reply_token, user: @user)
    end

    it "validates replytoken and creates message" do
      post_email @token.token
      response.response_code.should == 200
    end
  end
end
