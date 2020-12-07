class CreateFinalOrderedItems < ActiveRecord::Migration[6.0]
  def change
    create_table :final_ordered_items do |t|
      t.integer :product_variant_id
      t.integer :quantity
      t.numeric :price
      t.bigint :final_order_id
      t.numeric :subtotal

      t.timestamps
    end
  end
end
