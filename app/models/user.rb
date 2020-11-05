class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  before_validation{email.downcase!}
  before_destroy :admin_destroy?
  # before_update :admin_update?
  # after_save :admin_none?
  validate :admin_update?
  validates :name, presence: true, length: {maximum: 30}
  validates :email, presence: true, length: {maximum: 255},
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: true
  validates :password, presence: true, length: {  minimum: 6}
  has_secure_password
  
  private
  def admin_update?
    if persisted? && User.where(admin: true).count ==1 && (admin_changed? && admin == false)
      errors.add(:admin, "管理者権限のアカウントは最低でも１人いないといけないため、アカウントの権限を変更できません")
    end
  end
  def admin_destroy?
    if User.where(admin: true).count < 2 && self.admin
      errors.add(:admin, "管理者権限のアカウントは最低でも１人いないといけないため、アカウントを削除できません") 
      throw :abort
    end
    
  end

  # def admin_update?
  #   binding.irb
  #   # throw :abort if User.where(admin: true).count < 2 && self.admin
  # end
end