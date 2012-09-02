require 'spec_helper'

def post_message
  post :create, message: attributes_for(:message), format: :json
end

def post_invalid_message
  post :create, message: attributes_for(:invalid_message), format: :json
end

describe MessagesController do
  before do
    @user = create(:user)
    login_user
  end

  describe "GET #index" do
    before { get :index }

    it "fetches messages" do
      messages = create(:message)
      assigns(:messages).should be_a(Mongoid::Criteria)
      assigns(:messages).klass.should == Message
    end

    it "shows the :index view" do
      response.should render_template :index
    end
  end

  describe "GET #bb" do
    before { get :bb }

    it "fetches messages" do
      messages = create(:message)
      assigns(:messages).should be_a(Mongoid::Criteria)
      assigns(:messages).klass.should == Message
    end

    it "shows the :bb view" do
      response.should render_template :bb
    end
  end

  describe "GET #show" do
    before do
      @message = create(:message)
      get :show, id: @message.id, format: :json
    end

    it "fetches the message" do
      assigns(:message).should eq(@message)
    end

    it "renders the message" do
      parsed_body = JSON.parse(response.body)
      parsed_body["text"].should eq(@message.text)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new message in the database" do
        expect{
          post_message
        }.to change(Message,:count).by(1)
      end

      it "renders the message" do
        post_message
        parsed_body = JSON.parse(response.body)
        parsed_body.should have_key("text")
      end
    end

    context "with invalid attributes" do
      it "does not save the new message in the database" do
        expect{
          post_invalid_message
        }.to_not change(Message,:count)
      end

      it "renders the errors" do
        post_invalid_message
        parsed_body = JSON.parse(response.body)
        parsed_body.should have_key("errors")
      end
    end
  end
end
