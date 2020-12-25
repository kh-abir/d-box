class AddUserNameToFinalOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :final_orders, :name, :string
  end
end
