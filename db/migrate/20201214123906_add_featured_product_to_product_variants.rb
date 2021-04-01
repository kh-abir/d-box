class AddFeaturedProductToProductVariants < ActiveRecord::Migration[6.0]
  def change
    add_column :product_variants, :featured, :boolean, default: :false
  end
end
