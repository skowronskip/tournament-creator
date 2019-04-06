class Game < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }
  validates :code, presence: true, length: { maximum: 6 }
end
