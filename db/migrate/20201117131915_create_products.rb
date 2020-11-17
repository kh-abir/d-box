class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :title
      t.bigint :sub_category_id
      t.timestamps
    end
  end
end
