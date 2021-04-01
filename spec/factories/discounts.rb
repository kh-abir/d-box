require 'faker'
include ActionDispatch::TestProcess::FixtureFile

FactoryBot.define do
  factory :discount do
    discount_type {"Fixed"}
    discountable_type {"Product"}
    discountable_id {12}
    amount {50.00}
    valid_from {Time.now}
    valid_till {Time.now + 2.weeks}
  end
end