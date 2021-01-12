class Category < ApplicationRecord
  has_many :sub_categories
  has_many :products
  has_one_attached :category_icon
  has_many :discounts, as: :discountable

end
