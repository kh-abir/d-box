class ProductsSubCategory < ApplicationRecord
  belongs_to :product
  belongs_to :sub_category
end
