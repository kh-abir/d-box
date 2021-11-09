class AddUnitToOrderedItems < ActiveRecord::Migration[6.0]
  def change
    add_column :ordered_items, :unit, :string
  end
end
