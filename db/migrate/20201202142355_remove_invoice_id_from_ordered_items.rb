class RemoveInvoiceIdFromOrderedItems < ActiveRecord::Migration[6.0]
  def change
    remove_column :ordered_items, :invoice_id, :integer
  end
end
