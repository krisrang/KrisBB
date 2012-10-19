require 'faker'

FactoryGirl.define do
  factory :user do
    username { Faker::Name.first_name }
    email { Faker::Internet.email }
    notify_me true
    salt 'salty salt'
    crypted_password { Sorcery::CryptoProviders::BCrypt.encrypt('secret', 'salty salt') }
    #activation_state 'active'
  end
end
