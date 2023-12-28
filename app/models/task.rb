class Task < ApplicationRecord
  belongs_to :project
  belongs_to :user, optional: true

  validates :name, presence: true
  validates :project, presence: true

  before_validation :set_default_status
  validates :status, inclusion: { in: ["todo", "in progress", "done"] }

  private

  def set_default_status
    self.status ||= 'todo'
  end
end
