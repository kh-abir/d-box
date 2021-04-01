class AddPrecisionToProductVariants < ActiveRecord::Migration[6.0]
  def change
    change_column :product_variants, :price, :decimal, precision: 8, scale: 2, null: false
    change_column :product_variants, :purchase_price, :decimal, precision: 8, scale: 2, null: false
  end
end
