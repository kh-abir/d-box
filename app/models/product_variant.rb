class ProductVariant < ApplicationRecord

  enum gender: {no: false, yes: true}

  belongs_to :product, dependent: :destroy
  has_many :ordered_items
  belongs_to :final_ordered_item, optional: true

end
