FactoryBot.define do
  factory :match do
    homePoints {2}
    awayPoints {0}
    home_team_id { create(:participant).id }
    away_team_id { create(:participant).id }
    tournament_id { create(:tournament).id }
  end
end