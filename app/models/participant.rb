class Participant < ApplicationRecord
  has_many :as_home_team, class_name: 'Match', foreign_key: 'home_team_id'
  has_many :as_away_team, class_name: 'Match', foreign_key: 'away_team_id'
  belongs_to :tournament
  validates :name, presence: true, length: { maximum: 50 }
end
