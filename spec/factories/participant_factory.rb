FactoryBot.define do
  factory :participant do
    name { Faker::Football.team }
    tournament_id { create(:tournament).id }
  end
end