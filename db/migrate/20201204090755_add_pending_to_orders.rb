class AddPendingToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :pending, :boolean, default: :false
  end
end
