class CreateDiscounts < ActiveRecord::Migration[6.0]
  def change
    create_table :discounts do |t|
      t.string :discount_name
      t.string :discount_type
      t.decimal :amount
      t.datetime :valid_from
      t.datetime :valid_till
      t.references :discountable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
