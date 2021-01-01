class DropPicture < ActiveRecord::Migration[6.0]
  def change
    drop_table :pictures
  end
end
