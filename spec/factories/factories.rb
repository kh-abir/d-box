require 'faker'
include ActionDispatch::TestProcess::FixtureFile

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test-#{rand(10000..100000000)}}@sample.com" }
    password { "123456" }
    confirmed_at {Time.now}
    first_name {Faker::Name.name}
    last_name {Faker::Name.name}
    contact {Faker::PhoneNumber}
    gender {"male"}
    role {"user"}
  end

  factory :category do
    trait :with_avatar do
      after :create do |account|
        file_path = Rails.root.join('spec', 'support', 'assets', 'image-not-found.png')
        file = fixture_file_upload(file_path, 'image/png')
        account.category_icon.attach(file)
      end
    end
    title {Faker::Name.name}
  end

  factory :coupon do
    code {"Test Coupon"}
    amount {50}
    valid_from {Time.now}
    valid_till {Time.now + 2.weeks}
  end

  factory :product_variant do
    details {"Test Product Variant details"}
    price {1200}
    in_stock {10}
    purchase_price {1100}
  end

  factory :product do
    title {Faker::Name.name}
  end

  factory :sub_category do
    title {Faker::Name.name}
  end
end