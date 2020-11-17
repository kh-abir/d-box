class CreateProductVariants < ActiveRecord::Migration[6.0]
  def change
    create_table :product_variants do |t|
      t.text :details
      t.decimal :price
      t.bigint :product_id
      t.timestamps
    end
  end
end
