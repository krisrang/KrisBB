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

  attr_protected :html

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

      value = smilie_parse(value)

      self.html = value
    end

    def smilie_parse(text)
      Message.smilies.each do |k, v|
        text.gsub! k, "<i class=\"smilie smilies-#{v}\"></i>"
      end

      text
    end
end
