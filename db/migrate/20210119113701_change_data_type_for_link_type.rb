class ChangeDataTypeForLinkType < ActiveRecord::Migration[6.0]
  def self.up
    change_table :banners do |t|
      t.change :link_type, :string
    end
  end
  def self.down
    change_table :banners do |t|
      t.change :link_type, :integer
    end
  end
end
