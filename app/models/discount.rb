class Discount < ApplicationRecord
  belongs_to :discountable, polymorphic: true
end
