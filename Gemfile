source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

#Custom added gem
gem 'devise', '~> 4.2'
gem 'devise-async'
gem 'cancancan', '~> 3.1'
gem 'image_processing', '~> 0.2.3'
gem "mini_magick"
gem 'cocoon'
gem 'font-awesome-rails'
gem 'chartkick'
gem 'groupdate'
gem 'will_paginate'
gem 'active_link_to'
gem 'owlcarousel-rails'
gem 'jquery-rails'
gem 'momentjs-rails'
gem 'bootstrap-daterangepicker-rails'
gem 'chosen-rails'
gem 'simplest_status'
gem 'stripe-rails'
gem 'stripe-ruby-mock', '~> 3.0.1', :require => 'stripe_mock'
gem 'country_select'
gem 'simplecov', require: false, group: :test
gem 'letter_opener'
gem 'letter_opener_web'
gem 'faker', :git => 'https://github.com/faker-ruby/faker.git', :branch => 'master'
gem 'sidekiq'

gem 'rails', '~> 6.0.3', '>= 6.0.3.4'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 4.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  gem 'factory_bot_rails'
  gem 'rspec-rails', '~> 4.0.2'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
  gem 'rails-controller-testing'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
