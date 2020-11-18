class Invoice < ApplicationRecord
  has_many :ordered_items
  has_many :product_variants
end
