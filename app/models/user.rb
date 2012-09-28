require 'securerandom'

class User
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :messages
  has_many :reply_tokens

  mount_uploader :avatar, AvatarUploader

  field :username
  field :token
  field :admin, type: Boolean,  default: false
  field :colour, type: Integer
  field :notify_me, type: Boolean, default: false

  attr_accessor :remember_me, :password_confirmation, :deleted
  attr_protected :admin

  validates_presence_of :email, if: :notify_me, message: "cannot be blank if you have notification checked"
  validates_presence_of :username
  validates_confirmation_of :password, if: :password
  validates_length_of :password, minimum: 6, maximum: 16, if: :password

  authenticates_with_sorcery!

  before_create :enable_signup
  before_save :generate_token, :generate_colour

  def as_json(options = {})
    included = options[:include] || []
    serializable_hash(options).tap do |hash|
      hash.delete "password"
      hash.delete "crypted_password"
      hash.delete "salt"
      hash.delete "token" unless included.include?(:token)
      hash.delete "unlock_token"
      hash.delete "lock_expires_at"
      hash.delete "failed_logins_count"
      hash.delete "remember_me_token"
      hash.delete "remember_me_token_expires_at"
      hash[:deleted] = true if self.new_record?
    end
  end

  def self.deleted_user
    self.new(colour: 1, username: "Deleted", deleted: true)
  end

  def online?
    self.last_activity_at > 15.minutes.ago
  end

  protected
    def enable_signup
      Settings.enable_signup
    end

    def generate_token
      self.token = SecureRandom.base64(15).tr('+/=lIO0', 'pqrsxyz') if self.token.nil?
    end

    def generate_colour
      self.colour = rand 1..5 if self.colour.nil?
      #self.colour = "%06x" % (rand * 0xffffff)
    end
end
