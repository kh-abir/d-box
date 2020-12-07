class AddPurchasePriceToFinalOrderedItems < ActiveRecord::Migration[6.0]
  def change
    add_column :final_ordered_items, :purchase_price, :numeric
  end
end
