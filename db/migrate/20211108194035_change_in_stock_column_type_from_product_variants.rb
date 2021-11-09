class ChangeInStockColumnTypeFromProductVariants < ActiveRecord::Migration[6.0]
  def change
    remove_column :product_variants, :in_stock
    add_column :product_variants, :in_stock, :decimal
  end
end
