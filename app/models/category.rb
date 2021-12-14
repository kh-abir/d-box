class Category < ApplicationRecord
  has_many :sub_categories, dependent: :destroy
  has_one_attached :category_icon
  has_one :discount, as: :discountable
  has_many :banners

  validates :title, presence: true

end
