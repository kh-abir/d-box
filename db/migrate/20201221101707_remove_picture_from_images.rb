class RemovePictureFromImages < ActiveRecord::Migration[6.0]
  def change
    remove_column :images, :picture, :binary
  end
end
