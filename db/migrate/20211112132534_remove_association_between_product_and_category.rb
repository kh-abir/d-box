class RemoveAssociationBetweenProductAndCategory < ActiveRecord::Migration[6.0]
  def change
    remove_column :products, :category_id, :integer
  end
end
