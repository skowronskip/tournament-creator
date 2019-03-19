class Tournament < ApplicationRecord
  enum state: [:stopped, :paused, :in_progress, :finished]
  enum type: [:cup, :groups, :cup_groups]
  has_many :matches, foreign_key: 'tournament_id'
  has_many :participants, foreign_key: 'tournament_id'
  validates :name, presence: true, length: { maximum: 50 }
end
