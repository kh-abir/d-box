class AddAddressToFinalOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :final_orders, :address, :string
  end
end