class AddCountryToShippingAddress < ActiveRecord::Migration[6.0]
  def change
    add_column :shipping_addresses, :country, :string
  end
end
