class Product < ApplicationRecord
  belongs_to :sub_category
  belongs_to :category
  has_many :product_variants, dependent: :destroy
  has_many :discounts, as: :discountable
  has_one_attached :brand_image

  accepts_nested_attributes_for :product_variants, reject_if: :all_blank, allow_destroy: true

  PER_PAGE = 10

end
