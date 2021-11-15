class RemoveAssociationBetweenProductAndSubCategory < ActiveRecord::Migration[6.0]
  def change
    remove_column :products, :sub_category_id, :bigint
  end
end
