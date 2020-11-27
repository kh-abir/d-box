class Product < ApplicationRecord
  belongs_to :sub_category
  belongs_to :category

  has_many :product_variants
end
