class AddStatusToFinalOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :final_orders, :status, :integer
  end
end
