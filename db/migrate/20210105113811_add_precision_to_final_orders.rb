class AddPrecisionToFinalOrders < ActiveRecord::Migration[6.0]
  def change
    change_column :final_orders, :purchase_price, :decimal, precision: 8, scale: 2, null: false
  end
end
