class AddColumnToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :gender, :integer
    add_column :users, :admin, :integer , default: 0
  end
end
