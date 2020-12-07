class OrderedItem < ApplicationRecord
  belongs_to :order
  belongs_to :product_variant, optional: true


  before_save :total, :sub_purchase_price

  # def total
  #   total = price.to_i * quantity.
  # end

    def total
      if price && quantity
        total = price * quantity
      else
        total = "0.0".to_d
      end
    end


    def sub_purchase_price
    purchase_price = purchase_price.to_i
  end

end
