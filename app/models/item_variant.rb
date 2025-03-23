class ItemVariant < ApplicationRecord
  belongs_to :item
  validates :size, :color, :stock, presence: true
end
