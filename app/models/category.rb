class Category < ApplicationRecord
  belongs_to :parent, class_name: "Category", optional: true
  has_many :subcategories, class_name: "Category", foreign_key: "parent_id", dependent: :destroy
  has_many :items, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: { scope: :parent_id }
end
