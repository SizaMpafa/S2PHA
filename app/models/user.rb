class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { customer: 0, owner: 1 }, _default: :customer
  has_many :order_items
  validates :first_name, :last_name, presence: true
  validate :only_one_owner
  # before_destroy :prevent_owner_deletion

  private

  def only_one_owner
    if role == "owner" && User.where(role: :owner).where.not(id: id).exists?
      errors.add(:role, "only one owner is allowed")
    end
  end

  # def prevent_owner_deletion
  #   throw(:abort) if owner?
  # end
end
