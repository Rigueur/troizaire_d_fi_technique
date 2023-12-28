class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  has_many :projects, through: :tasks

  validates :name, presence: true, uniqueness: true
end
