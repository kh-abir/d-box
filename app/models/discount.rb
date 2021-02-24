class Discount < ApplicationRecord
  belongs_to :discountable, polymorphic: true, optional: true

  enum discount_type: {Percent: "Percent", Fixed: "Fixed"}

end
