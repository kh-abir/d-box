class Invoice < ApplicationRecord
  has_many :ordered_items

end
