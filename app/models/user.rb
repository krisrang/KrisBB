class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :admin, type: Boolean,  default: false

  #attr_accessible :email, :password, :password_confirmation

  authenticates_with_sorcery!

  before_create :enable_signup

  def avatar_url(size=96)
    hash = Digest::MD5.hexdigest(self.email || self.name)
    "http://robohash.org/#{hash}?size=#{size}x#{size}&gravatar=hashed"
  end

  protected
    def enable_signup
      Settings.enable_signup
    end
end
