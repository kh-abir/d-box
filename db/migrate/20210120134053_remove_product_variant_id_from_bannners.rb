class RemoveProductVariantIdFromBannners < ActiveRecord::Migration[6.0]
  def change
    remove_column :banners, :product_variant_id, :integer
  end
end
