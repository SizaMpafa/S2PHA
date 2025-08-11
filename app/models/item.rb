class Item < ApplicationRecord
  belongs_to :category
  has_many :item_variants, dependent: :destroy

  validates :name, :price, :category_id, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :stock, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true

  accepts_nested_attributes_for :item_variants, allow_destroy: true, reject_if: :all_blank
end
