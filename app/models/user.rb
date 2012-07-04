require 'securerandom'

class User
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :messages

  mount_uploader :avatar, AvatarUploader

  field :username
  field :token
  field :admin, type: Boolean,  default: false

  attr_accessor :remember_me, :password_confirmation
  attr_protected :admin

  validates_presence_of :username
  validates_confirmation_of :password, if: :password
  validates_length_of :password, minimum: 6, maximum: 16, if: :password

  authenticates_with_sorcery!

  before_create :enable_signup, :generate_token
  before_update :generate_token
  
  def as_json(options = nil)
    serializable_hash(options).tap do |hash|
      hash["id"] = self.id
      hash.delete "password"
      hash.delete "crypted_password"
      hash.delete "salt"
      hash.delete "token"
      hash.delete "unlock_token"
      hash.delete "lock_expires_at"
      hash.delete "failed_logins_count"
      hash.delete "remember_me_token"
      hash.delete "remember_me_token_expires_at"
    end
  end

  def api_key
    self.token
  end

  protected
    def enable_signup
      Settings.enable_signup
    end

    def generate_token
      self.token = SecureRandom.base64(15).tr('+/=lIO0', 'pqrsxyz') if self.token.nil?
    end
end
