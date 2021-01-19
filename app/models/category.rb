class Category < ApplicationRecord
  has_many :sub_categories, dependent: :destroy
  has_many :products, dependent: :destroy
  has_one_attached :category_icon
  has_many :banners, dependent: :destroy

end
