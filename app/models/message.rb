require 'rdiscount'

class Message
  include Mongoid::Document
  include Mongoid::Timestamps

  @@smilies = {
    ':)' => 'smile',
    ':(' => 'frown',
    ':confused:' => 'confused',
    ':mad:' => 'mad',
    ':lol:' => 'lol',
    ':p' =>  'tongue',
    ';)' => 'wink',
    ':D' => 'biggrin',
    ':o' => 'redface',
    ':rolleyes:' => 'rolleyes',
    ':cool:' => 'cool',
    ':eek:' => 'eek',
    ':facepalm:' => 'facepalm'
  }

  belongs_to :user
  has_many :reply_tokens
  delegate :username, :colour, to: :user, prefix: true

  field :text
  field :html
  field :email_html

  attr_protected :html, :email_html

  scope :list, includes(:user).desc(:created_at)
  scope :recent, desc(:created_at).limit(10)

  before_save :process_text
  validates_presence_of :text

  def as_json(options = nil)
    serializable_hash(options).tap do |hash|
      unless self.user.nil?
        hash[:user] = self.user
      else
        hash[:user] = User.deleted_user
      end
    end
  end

  def self.smilies
    @@smilies
  end

  protected
    def process_text
      value = RDiscount.new(self.text, :autolink).to_html

      value.gsub!(/\r\n?/u, "\n")
      value.gsub!(/([^\n]\n)(?=[^\n])/u, '\1<br />')

      self.email_html = smilie_parse(value, false)
      self.html = smilie_parse(value, true)
    end

    def smilie_parse(text, css=true)
      text.clone.tap do |txt|
        Message.smilies.each do |k, v|
          if css
            txt.gsub! k, "<i class=\"smilie smilies-#{v}\"></i>"
          else
            txt.gsub! k, "<img src=\"#{Settings.assethost.production}/assets/smilies/#{v}.png\" />"
          end
        end
      end
    end
end
