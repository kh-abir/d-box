class AddUnitToProductVariants < ActiveRecord::Migration[6.0]
  def change
    add_column :product_variants, :unit, :string, default: 'item'
  end
end
