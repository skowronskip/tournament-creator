FactoryBot.define do
  factory :participant do
    name { Faker::Football.team }
  end
end