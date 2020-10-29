class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  before_validation{email.downcase!}
  before_destroy :admin_lonely?
  validates :name, presence: true, length: {maximum: 30}
  validates :email, presence: true, length: {maximum: 255},
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: true
  validates :password, presence: true, length: {  minimum: 6}
  has_secure_password
  private

  def admin_lonely?
    throw :abort if User.where(admin: true).count < 2 && self.admin
  end
end