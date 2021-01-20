class CreateBanners < ActiveRecord::Migration[6.0]
  def change
    create_table :banners do |t|
      t.string :name
      t.integer :link_type
      t.integer :link_id

      t.timestamps
    end
  end
end
