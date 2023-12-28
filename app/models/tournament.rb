class Tournament < ApplicationRecord
  has_many :matches
  has_many :participations
  has_many :teams, through: :participations
end
