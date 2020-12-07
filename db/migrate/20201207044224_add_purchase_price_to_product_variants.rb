class AddPurchasePriceToProductVariants < ActiveRecord::Migration[6.0]
  def change
    add_column :product_variants, :purchase_price, :numeric
  end
end
