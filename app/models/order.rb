class Order < ApplicationRecord
  before_save :set_total_purchase_price, :set_total
  has_many :ordered_items
  belongs_to :user, optional: true

  extend SimplestStatus
  statuses :pending, :dispatched, :delivered, :canceled

  PER_PAGE = 10

  def total
    ordered_items.sum(:subtotal).to_d
  end

  private

  def set_total
    self[:total] = total
  end
  def set_total_purchase_price
    self[:total_purchase_price] = self.ordered_items.collect { |item| item.purchase_price * item.quantity }.sum.to_d
  end

end
