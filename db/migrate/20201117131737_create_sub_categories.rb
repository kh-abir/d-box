class CreateSubCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :sub_categories do |t|
      t.string :title
      t.bigint :category_id
      t.timestamps
    end
  end
end
