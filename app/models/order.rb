class Order < ApplicationRecord
  belongs_to :user
  belongs_to :user
  has_many :order_items
  has_one :payment, dependent: :destroy

  enum status: { pending: 0, approved: 1, declined: 2}, _default: :pending
  enum delivery_status: { processing: 0, shipped: 1, delivered: 2 }

  validates :total_price, presence: true
end
