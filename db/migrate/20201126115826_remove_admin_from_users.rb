class RemoveAdminFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :admin, :int
  end
end
