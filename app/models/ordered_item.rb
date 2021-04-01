class OrderedItem < ApplicationRecord
  before_save :set_subtotal
  belongs_to :order
  belongs_to :product_variant, optional: true

  scope :to_day, -> { where( 'created_at > ? AND created_at < ?', Date.today.beginning_of_day, Date.today.end_of_day )}
  scope :this_week, -> { where( 'created_at > ? AND created_at < ?', Date.today.beginning_of_week, Date.today.end_of_week )}
  scope :this_month, -> { where( 'created_at > ? AND created_at < ?', Date.today.beginning_of_month, Date.today.end_of_month )}
  scope :this_year, -> { where( 'created_at > ? AND created_at < ?', Date.today.beginning_of_year, Date.today.end_of_year )}
  scope :top_twenty_product, -> { group('product_variant_id').sum('quantity').sort_by{|k, v| v}.reverse.first(20)}
  scope :top_six_product, -> { group('product_variant_id').sum('quantity').sort_by{|k, v| v}.reverse.first(6)}

  def self.custom_date_revenue(start_date, end_date)
    total_incomes = OrderedItem.where('created_at >= ? AND created_at <= ?', start_date, end_date).sum("price*quantity")
    total_expenses = OrderedItem.where('created_at >= ? AND created_at <= ?', start_date, end_date).sum("purchase_price*quantity")
    revenue = total_incomes - total_expenses
    return revenue.to_d
  end

  def self.restore_ordered_items(order_id)
    order_items = OrderedItem.all.where("order_id = ?", order_id)
    order_items.each do |item|
      product_variant = ProductVariant.find(item.product_variant_id)
      product_variant.in_stock += item.quantity
      product_variant.save
    end
  end

  private
  def set_subtotal
    self[:subtotal] = price * quantity
  end

end
