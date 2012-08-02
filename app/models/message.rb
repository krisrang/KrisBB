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
    ':eek:' => 'eek'
  }

  belongs_to :user

  field :text
  field :html

  scope :recent, desc(:created_at).limit(5)

  before_save :process_text
  validates_presence_of :text

  def as_json(options = nil)
    serializable_hash(options).tap do |hash|
      hash["id"] = self.id
      hash["username"] = self.user.username
      hash["avatar"] = self.user.avatar.thumb.url
      hash["created_at_human"] = self.created_at.to_s :long_ordinal
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
      @@smilies.each do |k, v|
        text.gsub! k, "<i class=\"smilie smilies-#{v}\"></i>"
      end

      text
    end
end
