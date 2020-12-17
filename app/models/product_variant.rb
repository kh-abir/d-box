class ProductVariant < ApplicationRecord
  belongs_to :product, dependent: :destroy
  has_many :ordered_items
  belongs_to :final_ordered_item

end
