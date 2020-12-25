class AddPaymentMethodToFinalOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :final_orders, :payment_method, :integer
  end
end
