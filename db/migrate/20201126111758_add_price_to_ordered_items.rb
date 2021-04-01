class AddPriceToOrderedItems < ActiveRecord::Migration[6.0]
  def change
    add_column :ordered_items, :price, :decimal
  end
end
