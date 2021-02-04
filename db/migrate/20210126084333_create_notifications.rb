class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.references :product_variant, null: false, foreign_key: true
      t.integer :user_id

      t.timestamps
    end
  end
end
