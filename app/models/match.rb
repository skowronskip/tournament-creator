class Match < ApplicationRecord
  enum state: [:not_resolved, :resolved]
  belongs_to :home_team, class_name: 'Participant', foreign_key: 'home_team_id'
  belongs_to :away_team, class_name: 'Participant', foreign_key: 'away_team_id'
  belongs_to :tournament
end
