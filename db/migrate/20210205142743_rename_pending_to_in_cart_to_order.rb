class RenamePendingToInCartToOrder < ActiveRecord::Migration[6.0]
  def up
    remove_column :orders, :pending
  end

  def down
    add_column :orders, :in_cart, :boolean

  end
end
