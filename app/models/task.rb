class Task < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255}
  validates :content, presence: true
  validates :status, presence: true
  validates :priority, presence: true

  enum status: {wating: 0, working: 1, completed: 2}
  enum priority: {low: 0, middle: 1, high: 2}
end
