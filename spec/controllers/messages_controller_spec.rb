require 'spec_helper'

describe MessagesController do
  let (:message) { attributes_for :message }

  before do
    @user = create(:user)
  end

  def log_in
    login_user @user
  end

  def get_valid(action)
    request.env['HTTP_AUTHORIZATION'] = 
      ActionController::HttpAuthentication::Token.encode_credentials(@user.token)
    get action, format: :json
  end

  def get_invalid(action)
    request.env['HTTP_AUTHORIZATION'] = 
      ActionController::HttpAuthentication::Token.encode_credentials("bob loblaw")
    get action, format: :json
  end

  def post_email(token)
    data = YAML::load(File.open("#{Rails.root}/spec/fixtures/mailgun_email_post.yml"))
    post :from_email, data.merge({
      "recipient" => "#{token}.reply-message@krisbb.mailgun.org",
      "to" => "#{token}.reply-message@krisbb.mailgun.org",
      "To" => "#{token}.reply-message@krisbb.mailgun.org"})
  end

  def post_message
    post :create, {message: message}
  end

  def stub_notifier
    @notifier = Notifier.new
    controller.stub!(:notifier).and_return(@notifier)
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

  describe "GET #show" do
    it "shows message" do
      log_in
      @message = create(:message)
      get :show, id: @message.id, format: :json
      assigns(:message).should eq(@message)
      response.body.should have_content(@message.id)
    end
  end

  describe "POST #create" do
    before :each do
      log_in
    end

    it "sends pusher notification" do
      stub_notifier
      @notifier.should_receive(:new_message)
      post_message
    end

    it "creates message" do
      post_message
      Message.first.text.should eq(message[:text])
    end
  end

  describe "PUT #update" do
    it "updates message" do
      log_in
      @message = create(:message, user: @user)
      @message.text = "blabbery"
      put :update, message: {text: "blabbery"}, id: @message, format: :json
      assigns(:message).should eq(@message)
      response.response_code.should eq(204)
    end
  end

  describe "POST #from_email" do
    before do
      @message = create(:message)
      @token = create(:reply_token, message: @message, user: @user)
      post_email @token.token
    end

    it "validates replytoken" do
      response.response_code.should == 200
    end

    it "creates message" do
      Message.count.should eq(2)
    end
  end

  describe "DELETE #destroy" do
    before :each do
      log_in
      @message = create(:message, user: @user)
    end

    it "sends pusher notification" do
      stub_notifier
      @notifier.should_receive(:delete_message)
      delete :destroy, id: @message.id
    end 

    it "destroys the message" do
      delete :destroy, id: @message.id
      Message.where(id: @message.id).length.should eq(0)
    end
  end
end
