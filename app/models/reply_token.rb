require 'securerandom'

class ReplyToken
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :message
  belongs_to :user

  field :token
  field :enabled, type: Boolean, default: true

  before_create :generate_token

  index({ token: 1 })

  protected
    def generate_token
      self.token = SecureRandom.hex 10
    end
end
