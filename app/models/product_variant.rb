class ProductVariant < ApplicationRecord
  belongs_to :product
  belongs_to :ordered_item
end
