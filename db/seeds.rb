require 'faker'
puts "Seeding started at " + Time.now.strftime('%l:%M:%S')

User.where(email: "admin_test@dbox.org").first_or_create(
    first_name: 'Admin',
    last_name: 'Test',
    email: "admin_test@dbox.org",
    password: "111111",
    password_confirmation: "111111",
    gender: %w[male female other].sample,
    contact: Faker::Number.number(digits: 11),
    address: Faker::Address.full_address,
    role: "super_admin",
    confirmed_at: Time.now
)

10.times do
  first_name = Faker::Name.unique.first_name
  last_name = Faker::Name.unique.last_name
  contact = Faker::Number.number(digits: 11)
  address = Faker::Address.full_address
  User.where(email: "#{first_name}_#{last_name}@dbox.org").first_or_create(
      first_name: first_name,
      last_name: last_name,
      email: "#{first_name}_#{last_name}@dbox.org",
      password: "111111",
      password_confirmation: "111111",
      gender: %w[male female other].sample,
      contact: contact,
      address: address,
      confirmed_at: Time.now
  )
end

6.times do
  cat_title = Faker::Commerce.department(max: 1)
  category = Category.where(title: cat_title).first_or_create
  rand(1..10).times do |i|
    sub_category = category.sub_categories.where(title: "Sub_#{cat_title}_#{i}").first_or_create
    rand(1..10).times do
      product_title = Faker::Commerce.product_name.split[0]
      product = sub_category.products.where(title: product_title, category_id: category.id).first_or_create
      rand(1..10).times do |j|
        price = rand(1000..100000)
        product.product_variants.where(details: "#{product_title}'s variant_#{j}").first_or_create(
            details: "#{product_title}'s variant_#{j}",
            price: price.to_d + j.to_d,
            purchase_price: price - (price * 0.25),
            in_stock: rand(5..100),
            featured: %w[yes no].sample
        )
      end
    end
  end
end

categories = Category.all
sub_categories = SubCategory.all
products = Product.all

10.times do |index|
  product = products[rand(0...products.length)]
  category = categories[rand(0...categories.length)]
  sub_category = sub_categories[rand(0...sub_categories.length)]
  date1 = Faker::Date.in_date_period(month: 2)
  date2 = Faker::Date.in_date_period(month: 2)
  if index < 3
    Discount.where(discountable_type: 'Product', discountable_id: product.id).first_or_create(
        discount_type: %w[Percent Fixed].sample,
        amount: rand(1..20),
        valid_from: date1,
        valid_till: date2,
        discountable_type: 'Product',
        discountable_id: product.id
    )
    Banner.where(name: "Banner_#{index}", link_id: product.id, link_type: 'product').first_or_create
  elsif index < 6
    Discount.where(discountable_type: 'Category', discountable_id: category.id).first_or_create(
        discount_type: %w[Percent Fixed].sample,
        amount: rand(1..25),
        valid_from: date1,
        valid_till: date2,
        discountable_type: 'Category',
        discountable_id: category.id
    )
    Banner.where(name: "Banner_#{index}", link_id: category.id, link_type: 'category').first_or_create
  elsif index < 9
    Banner.where(name: "Banner_#{index}", link_id: sub_category.id, link_type: 'sub_category').first_or_create
  else
    Banner.where(name: "Banner_#{index}", link_type: 'without_link').first_or_create
  end


  promo_code = Faker::Commerce.promotion_code(digits: 2)
  Coupon.where(code: promo_code).first_or_create(
      code: promo_code,
      amount: rand(50..100),
      valid_from: date1,
      valid_till: date2
  )

end


puts "Seeding completed at " + Time.now.strftime('%l:%M:%S')
