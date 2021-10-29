class AddStreetToShippingAddress < ActiveRecord::Migration[6.0]
  def change
    add_column :shipping_addresses, :street, :string
  end
end
