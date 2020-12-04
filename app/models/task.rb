class Task < ApplicationRecord
  belongs_to :user
  has_many :labellings, dependent: :destroy
  has_many :labels, through: :labellings
  validates :name, presence: true, length: { maximum: 255}
  validates :content, presence: true
  validates :status, presence: true
  validates :priority, presence: true
  validates :deadline, presence: true

  enum status: {wating: 0, working: 1, completed: 2}
  enum priority: {low: 0, middle: 1, high: 2}


  scope :search, -> (search_params) do
    return if search_params.blank?
    name_like(search_params[:name]).status_is(search_params[:status])
  end
  scope :name_like, -> (name) {where('tasks.name LIKE ?', "%#{name}%") if name.present? }  
  scope :status_is, -> (status) {where(status: status) if status.present?}
end
