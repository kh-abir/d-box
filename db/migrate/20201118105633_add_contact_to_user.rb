class AddContactToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :contact, :decimal
  end
end
