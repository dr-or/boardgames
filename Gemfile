source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

gem 'bootsnap', require: false

gem 'carrierwave'
gem 'rmagick'

gem 'devise'
gem 'devise-i18n'
gem 'rails-i18n'

gem "cssbundling-rails", "~> 1.1"
gem "jsbundling-rails", "~> 1.1"

gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.4'
gem 'sprockets-rails'
gem 'turbo-rails'

group :development, :test do
  gem 'debug', platforms: %i[ mri mingw x64_mingw ]
  gem 'dotenv-rails', require: 'dotenv/rails-now'
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
