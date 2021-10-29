require 'faker'
include ActionDispatch::TestProcess::FixtureFile

FactoryBot.define do

  factory :ordered_item do
    quantity {1}
  end

  factory :order do
    total {1340}
    total_purchase_price {1200}
  end
end