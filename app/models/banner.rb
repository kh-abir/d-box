class Banner < ApplicationRecord
  belongs_to :product, optional: true
  belongs_to :category, optional: true
  belongs_to :sub_category, optional: true

  enum link_type: {without_link: 0, product: 1, sub_category: 2, category: 3}

end
