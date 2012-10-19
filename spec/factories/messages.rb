require 'faker'

FactoryGirl.define do
  factory :message do
    user
    text { Faker::Lorem.paragraph }
  end

  factory :invalid_message, class: Message do
  end
end
