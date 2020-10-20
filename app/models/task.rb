class Task < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255}
  validates :content, presence: true
  validates :status, presence: true

  enum status: {wating: 0, working: 1, completed: 2}
end
