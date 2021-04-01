require 'faker'
include ActionDispatch::TestProcess::FixtureFile

FactoryBot.define do
  factory :banner do
    name {Faker::Name.name}

    trait :with_avatar do
      after :create do |account|
        file_path = Rails.root.join('spec', 'support', 'assets', 'image-not-found.png')
        file = fixture_file_upload(file_path, 'image/png')
        account.banner_image.attach(file)
      end
    end

    trait :without_link do
      link_type {"without_link"}
    end

    trait :product_banner do
      link_type {"product"}
    end

    trait :subcategory_banner do
      link_type {"sub_category"}
    end

    trait :category_banner do
      link_type {"category"}
    end
  end
end