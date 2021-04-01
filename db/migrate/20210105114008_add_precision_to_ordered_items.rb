class AddPrecisionToOrderedItems < ActiveRecord::Migration[6.0]
  def change
    change_column :ordered_items, :price, :decimal, precision: 8, scale: 2, null: false
    change_column :ordered_items, :purchase_price, :decimal, precision: 8, scale: 2, null: false
  end
end
