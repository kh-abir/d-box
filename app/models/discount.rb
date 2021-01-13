class Discount < ApplicationRecord
  belongs_to :discountable, polymorphic: true

  enum discount_type: {percent: 'Percent', fixed: 'Fixed'}
end
