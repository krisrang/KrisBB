require 'faker'

FactoryGirl.define do
  factory :reply_token do
    user
    message
  end
end
