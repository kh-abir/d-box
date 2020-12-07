class Order < ApplicationRecord
  has_many :ordered_items
  belongs_to :user, optional: true

  before_save :set_sub_total, :set_purchase_price
  before_create :set_pending

  def sub_total
    ordered_items.collect { |order_item| order_item.price && order_item.quantity ?  order_item.price * order_item.quantity : 0 }.sum
  end

  def purchase_price
    ordered_items.collect { |order_item| order_item.price && order_item.quantity ? order_item.purchase_price : 0 }.sum
  end

  private

  def set_pending
    self[:pending] = true
  end
  def set_sub_total
    self[:sub_total] = sub_total.to_i
  end
  def set_purchase_price
    self[:purchase_price] = purchase_price
  end

end
