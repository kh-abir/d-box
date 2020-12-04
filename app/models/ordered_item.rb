class OrderedItem < ApplicationRecord
  belongs_to :order
  belongs_to :product_variant, optional: true


  before_save :total

  def total
    total = price * quantity
  end

end
