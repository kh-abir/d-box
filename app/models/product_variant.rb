class ProductVariant < ApplicationRecord
  belongs_to :product
  has_many :ordered_items

end
