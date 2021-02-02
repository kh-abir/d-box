class SubCategory < ApplicationRecord
  belongs_to :category
  has_many :products, dependent: :destroy
  has_many :banners, dependent: :destroy

end
