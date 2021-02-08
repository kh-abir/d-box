class AddInCartToOrder < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :in_cart, :boolean
  end
end
