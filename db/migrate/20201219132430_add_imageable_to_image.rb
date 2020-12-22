class AddImageableToImage < ActiveRecord::Migration[6.0]
  def change
    add_column :images, :imageable_type, :string
    add_column :images, :imageable_id, :integer
  end
end
