class RemoveColumnFromUser < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :contact, :string
  end
end
