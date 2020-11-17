class AddColumnToProductVariants < ActiveRecord::Migration[6.0]
  def change
    add_column :product_variants, :in_stock, :integer
  end
end
