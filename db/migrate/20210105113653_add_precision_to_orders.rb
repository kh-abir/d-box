class AddPrecisionToOrders < ActiveRecord::Migration[6.0]
  def change
    change_column :orders, :purchase_price, :decimal, precision: 8, scale: 2, null: false
  end
end
