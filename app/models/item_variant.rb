class ItemVariant < ApplicationRecord
  belongs_to :item

  validates :size, :color, presence: true
  validates :stock, numericality: { greater_than_or_equal_to: 0 }

  def display_name
    "Size: #{size}, Color: #{color}"
  end
end
