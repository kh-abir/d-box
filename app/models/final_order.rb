class FinalOrder < ApplicationRecord
  has_many :final_ordered_items, dependent: :destroy



end
