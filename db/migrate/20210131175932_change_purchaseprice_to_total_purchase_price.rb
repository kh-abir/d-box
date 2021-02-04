class ChangePurchasepriceToTotalPurchasePrice < ActiveRecord::Migration[6.0]
  def change
    remove_column :orders, :purchase_price, :decimal
    add_column :orders, :total_purchase_price, :decimal
  end
end
