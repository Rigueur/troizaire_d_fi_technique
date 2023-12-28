class Player < ApplicationRecord
  belongs_to :team, optional: true

  validates :name, :role, presence: true
  validates :role, inclusion: { in: %w(tank heal DPS),
  message: "%{value} is not a valid role" }
end
