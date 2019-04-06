require 'faker'

FactoryBot.define do
  factory :user do
    login { "MyString" }
    email { Faker::Internet.email }
    password { "MyString" }
  end
end
