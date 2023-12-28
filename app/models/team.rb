class Team < ApplicationRecord
  has_many :players
  has_many :matches_as_team_a, class_name: 'Match', foreign_key: :team_a_id
  has_many :matches_as_team_b, class_name: 'Match', foreign_key: :team_b_id
  has_many :participations
  has_many :tournaments, through: :participations

  validates :name, :city, presence: true
  validates :name, length: { maximum: 50 }

  def matches
    Match.where("team_a_id = ? OR team_b_id = ?", self.id, self.id)
  end
end
