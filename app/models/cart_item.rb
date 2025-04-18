class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :item
  belongs_to :item_variant
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 1 }
end
