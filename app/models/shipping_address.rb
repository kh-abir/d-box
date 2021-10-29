class ShippingAddress < ApplicationRecord
  belongs_to :user
  validates :user_id, :email, :street, :city, :country, :zip, presence: true

  def country_name
    country_name = ISO3166::Country[country]
    country_name.translations[I18n.locale.to_s] || country_name.name
  end
end