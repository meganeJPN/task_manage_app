class Task < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255}
  validates :content, presence: true
end