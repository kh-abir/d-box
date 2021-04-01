class RemoveTotalFromOrderedItems < ActiveRecord::Migration[6.0]
  def change
    remove_column :ordered_items, :total, :numeric
  end
end
