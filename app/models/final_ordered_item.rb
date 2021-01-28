class FinalOrderedItem < ApplicationRecord
  belongs_to :final_order
  belongs_to :product_variant, optional: true

  scope :to_day, -> { where( 'created_at > ? AND created_at < ?', Date.today.beginning_of_day, Date.today.end_of_day )}
  scope :this_week, -> { where( 'created_at > ? AND created_at < ?', Date.today.beginning_of_week, Date.today.end_of_week )}
  scope :this_month, -> { where( 'created_at > ? AND created_at < ?', Date.today.beginning_of_month, Date.today.end_of_month )}
  scope :this_year, -> { where( 'created_at > ? AND created_at < ?', Date.today.beginning_of_year, Date.today.end_of_year )}
  scope :top_twenty_product, -> { group('title').sum('quantity').sort_by{|k, v| v}.reverse.first(20)}



end
