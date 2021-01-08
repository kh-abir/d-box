class FinalOrder < ApplicationRecord

  belongs_to :user
  has_many :final_ordered_items, dependent: :destroy

  enum status:{pending: 0, delivered: 1}

  PER_PAGE = 10


end
