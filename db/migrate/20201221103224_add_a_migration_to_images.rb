class AddAMigrationToImages < ActiveRecord::Migration[6.0]
  def change
    add_index :images, [:imageable_type, :imageable_id]
  end
end
