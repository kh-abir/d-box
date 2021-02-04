class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def has_valid(discount_or_coupon)
    valid_from = 0
    valid_till = 0
    if discount_or_coupon === 'Discount'
      if self.discount
        valid_from = self.discount.valid_from
        valid_till = self.discount.valid_till
      end
    elsif discount_or_coupon === 'Coupon'
      valid_from = self.valid_from
      valid_till = self.valid_till
    end
    (Time.current + 6.hours).between?(valid_from,valid_till)
  end

  def discount_price(item)
    discount = self.discount
    if discount.discount_type == "Percent"
      price = item.price - (item.price * discount.amount * 0.01)
    else
      price = (item.price - discount.amount)
    end
    price
  end

  def save_amount
    product = self.product
    category = self.product.category

    if product.has_valid('Discount')
      if product.discount.discount_type == "Percent"
        "Save " + product.discount.amount.to_i.to_s + "%"
      else
        "Save flat " + product.discount.amount.to_i.to_s + " taka"
      end
    elsif category.has_valid('Discount')
      if category.discount.discount_type == "Percent"
        "Save " + category.discount.amount.to_i.to_s + "%"
      else
        "Save flat " + category.discount.amount.to_i.to_s+ " taka"
      end
    end
  end

end
