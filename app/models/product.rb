class Product < ApplicationRecord
  belongs_to :sub_category

  has_many :product_variants
end
