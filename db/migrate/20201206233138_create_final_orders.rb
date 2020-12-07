class CreateFinalOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :final_orders do |t|
      t.integer :user_id
      t.numeric :total

      t.timestamps
    end
  end
end
