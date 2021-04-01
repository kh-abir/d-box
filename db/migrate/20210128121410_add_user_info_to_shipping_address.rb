class AddUserInfoToShippingAddress < ActiveRecord::Migration[6.0]
  def change
    add_column :shipping_addresses, :order_id, :integer
    add_column :shipping_addresses, :full_name, :string
    add_column :shipping_addresses, :email, :string
    add_column :shipping_addresses, :phone, :string
    add_column :shipping_addresses, :city, :string
    add_column :shipping_addresses, :state, :string
    add_column :shipping_addresses, :zip, :string
    add_column :shipping_addresses, :payment_method, :string
  end
end
