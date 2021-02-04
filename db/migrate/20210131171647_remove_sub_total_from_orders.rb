class RemoveSubTotalFromOrders < ActiveRecord::Migration[6.0]
  def change
    remove_column :orders, :sub_total, :decimal
  end
end
