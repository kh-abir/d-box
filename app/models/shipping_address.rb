class ShippingAddress < ApplicationRecord
  belongs_to :user
  validates :user_id, :order_id, :full_name, :email, :address, :street, :city, :country, :zip, presence: true

end