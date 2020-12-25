class RemovePaymentMethodFromFinalOrders < ActiveRecord::Migration[6.0]
  def change
    remove_column :final_orders, :payment_method, :integer
  end
end
