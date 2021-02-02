class CreateCoupons < ActiveRecord::Migration[6.0]
  def change
    create_table :coupons do |t|
      t.string :code
      t.integer :amount
      t.datetime :valid_from
      t.datetime :valid_till

      t.timestamps
    end
  end
end
