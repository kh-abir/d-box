class ChangeColumnType < ActiveRecord::Migration[6.0]
  def change
    remove_column :banners, :link_type
    add_column :banners, :link_type, :integer
  end
end
