class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :item
  belongs_to :item_variant
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :item_variant_id, uniqueness: { scope: :cart_id, message: "is already in the cart" }
end
