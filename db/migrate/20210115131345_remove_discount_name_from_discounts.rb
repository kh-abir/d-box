class RemoveDiscountNameFromDiscounts < ActiveRecord::Migration[6.0]
  def change
    remove_column :discounts, :discount_name, :string
  end
end
