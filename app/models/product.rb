class Product < ApplicationRecord
  has_many :products_sub_categories, dependent: :destroy
  has_many :sub_categories, through: :products_sub_categories
  has_many :product_variants, dependent: :destroy
  has_one :discount, as: :discountable
  has_many :banners
  has_one_attached :brand_image
  accepts_nested_attributes_for :product_variants, reject_if: :all_blank, allow_destroy: true
  PER_PAGE = 10
  attr_accessor :sub_categories
end
