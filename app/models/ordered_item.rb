class OrderedItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :product_variant

end
