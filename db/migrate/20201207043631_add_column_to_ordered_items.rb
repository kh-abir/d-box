class AddColumnToOrderedItems < ActiveRecord::Migration[6.0]
  def change
    add_column :ordered_items, :purchase_price, :numeric
  end
end
