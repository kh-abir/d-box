class ProductVariant < ApplicationRecord
  belongs_to :product, dependent: :destroy
  has_many :ordered_items

end
