class AddPrecisionToFinalOrderedItem < ActiveRecord::Migration[6.0]
  def change
    change_column :final_ordered_items, :subtotal, :decimal, precision: 8, scale: 2, null: false
  end
end
