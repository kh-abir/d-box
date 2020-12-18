class ProductVariant < ApplicationRecord

  enum featured: {no: false, yes: true}

  belongs_to :product
  has_many :ordered_items
  belongs_to :final_ordered_item, optional: true
end
