class RemoveStateFromShippingAddress < ActiveRecord::Migration[6.0]
  def change
    remove_column :shipping_addresses, :state, :string
  end
end
