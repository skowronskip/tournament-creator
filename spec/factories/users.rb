FactoryBot.define do
  factory :user do
    login { "MyString" }
    email { "MyString" }
    password_digest { "MyString" }
  end
end
