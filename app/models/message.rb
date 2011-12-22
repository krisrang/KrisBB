class Message
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user

  field :contents, type: String
end
