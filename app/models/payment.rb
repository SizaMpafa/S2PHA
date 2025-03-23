class Payment < ApplicationRecord
  belongs_to :order
  enum status: { pending: 0, completed: 1, failed: 2 }, _default: :pending
  validates :amount, :payment_method, presence: true
end
