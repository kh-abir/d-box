class SubCategory < ApplicationRecord
  belongs_to :category
  has_many :products_sub_categories, dependent: :destroy
  has_many :products, through: :products_sub_categories
  has_many :banners

end
