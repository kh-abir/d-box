class AddEmailToFinalOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :final_orders, :email, :string
  end
end
