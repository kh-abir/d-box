class RemoveFullNameFromShippingAddress < ActiveRecord::Migration[6.0]
  def change
    remove_column :shipping_addresses, :full_name, :string
  end
end
