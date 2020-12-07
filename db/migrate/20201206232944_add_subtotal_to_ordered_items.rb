class AddSubtotalToOrderedItems < ActiveRecord::Migration[6.0]
  def change
    add_column :ordered_items, :subtotal, :numeric
  end
end
