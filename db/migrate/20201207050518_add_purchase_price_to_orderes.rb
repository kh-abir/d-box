class AddPurchasePriceToOrderes < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :purchase_price, :numeric
  end
end
