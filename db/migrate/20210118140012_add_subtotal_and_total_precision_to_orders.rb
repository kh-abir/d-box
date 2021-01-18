class AddSubtotalAndTotalPrecisionToOrders < ActiveRecord::Migration[6.0]
  change_column :orders, :total, :decimal, precision: 8, scale: 2
  change_column :orders, :sub_total, :decimal, precision: 8, scale: 2
end
