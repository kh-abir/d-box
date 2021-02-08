class RemoveStatusFromOrder < ActiveRecord::Migration[6.0]
  def change
    remove_column :orders, :status, :integer
  end
end
