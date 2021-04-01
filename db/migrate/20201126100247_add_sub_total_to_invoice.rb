class AddSubTotalToInvoice < ActiveRecord::Migration[6.0]
  def change
    add_column :invoices, :sub_total, :decimal
  end
end
