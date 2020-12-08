class FinalOrderedItem < ApplicationRecord
  belongs_to :final_order
  has_many :product_variants

end
