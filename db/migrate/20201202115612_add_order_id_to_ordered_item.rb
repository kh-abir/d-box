class AddOrderIdToOrderedItem < ActiveRecord::Migration[6.0]
  def change
    add_column :ordered_items, :order_id, :bigint
    add_column :ordered_items, :total, :decimal
  end
end
