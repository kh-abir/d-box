class AddTitleToProductVariants < ActiveRecord::Migration[6.0]
  def change
    add_column :final_ordered_items, :title, :string
  end
end
