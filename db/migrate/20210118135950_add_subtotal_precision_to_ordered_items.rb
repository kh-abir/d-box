class AddSubtotalPrecisionToOrderedItems < ActiveRecord::Migration[6.0]
  change_column :ordered_items, :subtotal, :decimal, precision: 8, scale: 2, null: false
end
