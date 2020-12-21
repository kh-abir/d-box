class ProductVariant < ApplicationRecord
  enum featured: {no: false, yes: true}
  belongs_to :product
  has_many :ordered_items
  belongs_to :final_ordered_item, optional: true
  has_many :images, as: :imageable

  accepts_nested_attributes_for :images, reject_if: :all_blank, allow_destroy: true

end
