class OrderedItem < ApplicationRecord
  belongs_to :order
  belongs_to :product_variant, optional: true

  before_save :set_subtotal

  private
  def set_subtotal
    self.subtotal = price * quantity
  end

end
