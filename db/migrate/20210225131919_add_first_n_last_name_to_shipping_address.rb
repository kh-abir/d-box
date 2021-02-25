class AddFirstNLastNameToShippingAddress < ActiveRecord::Migration[6.0]
  def change
    add_column :shipping_addresses, :first_name, :string
    add_column :shipping_addresses, :last_name, :string
  end
end
