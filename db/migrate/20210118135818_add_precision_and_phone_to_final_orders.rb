class AddPrecisionAndPhoneToFinalOrders < ActiveRecord::Migration[6.0]
  def change
    change_column :final_orders, :total, :decimal, precision: 8, scale: 2, null: false
    change_column :final_orders, :phone, :string
  end
end
