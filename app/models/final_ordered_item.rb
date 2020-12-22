class FinalOrderedItem < ApplicationRecord
  belongs_to :final_order
  belongs_to :product_variant, optional: true
end
