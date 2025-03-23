class Item < ApplicationRecord
  belongs_to :category
  has_many :item_variants, dependent: :destroy
  validates :name, :price, :stock, presence: true
end
