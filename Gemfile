source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

gem 'bootsnap', require: false

gem 'devise'
gem 'devise-i18n'
gem 'rails-i18n'

gem "cssbundling-rails", "~> 1.1"
gem "jsbundling-rails", "~> 1.1"

gem "image_processing", ">= 1.2"
gem 'active_storage_validations'
gem 'aws-sdk-s3'

gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.4'
gem 'sprockets-rails'
gem 'turbo-rails'
gem 'dotenv-rails', require: 'dotenv/rails-now'

group :development, :test do
  gem 'debug', platforms: %i[ mri mingw x64_mingw ]
  gem 'sqlite3', '~> 1.4'
end

gem "recaptcha"

group :development do
  gem "letter_opener"
  gem 'web-console'
end

group :production do
  gem 'pg'
end
