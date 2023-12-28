class Match < ApplicationRecord
  belongs_to :tournament
  belongs_to :team_a, class_name: 'Team'
  belongs_to :team_b, class_name: 'Team'

end
