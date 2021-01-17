class Discount < ApplicationRecord
  belongs_to :discountable, polymorphic: true

  enum discount_type: {Percent: "Percent", Fixed: "Fixed"}

end
