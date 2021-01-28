class FinalOrder < ApplicationRecord

  belongs_to :user
  has_many :final_ordered_items, dependent: :destroy

  enum status:{pending: 0, delivered: 1}

  PER_PAGE = 10

  def self.custom_date_revenue(start_date, end_date)
    total_incomes = FinalOrder.where('created_at > ? AND created_at < ?', start_date, end_date).sum(:total)
    total_expenses = FinalOrder.where('created_at > ? AND created_at < ?', start_date, end_date).sum(:purchase_price)
    revenue = total_incomes - total_expenses
    return revenue.to_i
  end

end
