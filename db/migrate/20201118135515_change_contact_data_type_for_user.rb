class ChangeContactDataTypeForUser < ActiveRecord::Migration[6.0]
  def change
    change_table :users do |t|
      t.change :contact, :string
    end
  end
end
