class AddPhoneToFinalOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :final_orders, :phone, :decimal
  end
end
