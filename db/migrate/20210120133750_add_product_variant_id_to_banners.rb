class AddProductVariantIdToBanners < ActiveRecord::Migration[6.0]
  def change
    add_column :banners, :product_variant_id, :integer
  end
end
