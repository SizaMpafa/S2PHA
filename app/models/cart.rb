class Cart < ApplicationRecord
  belongs_to :user, optional: true
  has_many :cart_items, dependent: :destroy
  has_many :items, through: :cart_items

  accepts_nested_attributes_for :cart_items, allow_destroy: true, reject_if: :all_blank
end
