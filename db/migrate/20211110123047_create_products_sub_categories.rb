class CreateProductsSubCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :products_sub_categories do |t|
      t.references :product, null: false, foreign_key: true
      t.references :sub_category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
