class AddAddressToShippingAddress < ActiveRecord::Migration[6.0]
  def change
    add_column :shipping_addresses, :address, :string
  end
end
