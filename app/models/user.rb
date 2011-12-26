class User
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :messages

  field :username
  field :admin, type: Boolean,  default: false

  attr_accessor :remember_me
  #attr_accessible :email, :password, :password_confirmation

  authenticates_with_sorcery!

  before_create :enable_signup

  def avatar_url(size=96)
    hash = Digest::MD5.hexdigest(self.email || self.username)
    "http://robohash.org/#{hash}?size=#{size}x#{size}&gravatar=hashed"
  end

  def as_json(options = nil)
    serializable_hash(options).tap do |hash|
      hash["id"] = self.id
      hash.delete "crypted_password"
      hash.delete "salt"
      hash.delete "failed_logins_count"
      hash.delete "remember_me_token"
      hash.delete "remember_me_token_expires_at"
    end
  end

  protected
    def enable_signup
      Settings.enable_signup
    end
end
