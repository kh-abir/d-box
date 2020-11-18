class OrderedItem < ApplicationRecord
  has_many :products
  belongs_to :invoice
end
