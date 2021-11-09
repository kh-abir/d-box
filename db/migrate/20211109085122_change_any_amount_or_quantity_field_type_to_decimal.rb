class ChangeAnyAmountOrQuantityFieldTypeToDecimal < ActiveRecord::Migration[6.0]
  def change
    remove_column :coupons, :amount
    add_column :coupons, :amount, :decimal

    remove_column :ordered_items, :quantity
    add_column :ordered_items, :quantity, :decimal
  end
end
