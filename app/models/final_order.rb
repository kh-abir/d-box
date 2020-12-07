class FinalOrder < ApplicationRecord
  belongs_to :user
  has_many :final_ordered_items, dependent: :destroy

end
