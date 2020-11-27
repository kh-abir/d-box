class Product < ApplicationRecord
  belongs_to :sub_category
  belongs_to :category
  has_many :product_variants

  accepts_nested_attributes_for :product_variants

end
