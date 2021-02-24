class ShippingAddress < ApplicationRecord
  belongs_to :user
  validates :city, :zip, presence: true

end