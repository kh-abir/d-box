class AddPurchasePriceToFinalOrderes < ActiveRecord::Migration[6.0]
  def change
    add_column :final_orders, :purchase_price, :numeric
  end
end
