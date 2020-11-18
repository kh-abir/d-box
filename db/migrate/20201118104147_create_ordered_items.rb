class CreateOrderedItems < ActiveRecord::Migration[6.0]
  def change
    create_table :ordered_items do |t|
      t.integer :invoice_id
      t.integer :product_variant_id
      t.integer :quantity

      t.timestamps
    end
  end
end
