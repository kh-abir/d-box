class Order < ApplicationRecord
  before_save :set_total_purchase_price, :set_total
  before_create :set_pending

  has_many :ordered_items
  belongs_to :user, optional: true
  enum status:{pending: 0, delivered: 1}
  PER_PAGE = 10

  def self.custom_date_revenue(start_date, end_date)
    total_incomes = Order.where('created_at > ? AND created_at < ?', start_date, end_date).sum(:total)
    total_expenses = Order.where('created_at > ? AND created_at < ?', start_date, end_date).sum(:total_purchase_price)
    revenue = total_incomes - total_expenses
    return revenue.to_d
  end

  def total
    ordered_items.sum(:subtotal).to_d
  end

  private
  def set_pending
    self[:pending] = true
  end

  def set_total
    self[:total] = total
  end
  def set_total_purchase_price
    self[:total_purchase_price] = self.ordered_items.collect { |item| item.purchase_price * item.quantity }.sum.to_d
  end

end
