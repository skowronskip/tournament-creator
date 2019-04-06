FactoryBot.define do
  factory :tournament do
    name { "MyString" }
    user_id { create(:user).id }
    game_id { create(:game).id }
  end
end
