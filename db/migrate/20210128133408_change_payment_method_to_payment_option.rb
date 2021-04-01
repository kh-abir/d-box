class ChangePaymentMethodToPaymentOption < ActiveRecord::Migration[6.0]
  def change
    remove_column :shipping_addresses, :payment_method
    add_column :shipping_addresses, :payment_option, :string
  end
end
