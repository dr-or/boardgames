source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.4'

gem 'active_storage_validations'
gem 'aws-sdk-s3'
gem 'bcrypt_pbkdf', '>= 1.0', '< 2.0'
gem 'bootsnap', require: false
gem 'cssbundling-rails', '~> 1.1'
gem 'devise'
gem 'devise-i18n'
gem 'ed25519', '>= 1.2', '< 2.0'
gem 'image_processing', '>= 1.2'
gem 'jsbundling-rails', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'pundit', '~> 2.3'
gem 'rails', '~> 7.0.4'
gem 'rails-i18n'
gem 'resque'
gem 'sprockets-rails'
gem 'turbo-rails'

group :development, :test do
  gem 'debug', platforms: %i[ mri mingw x64_mingw ]
  gem 'sqlite3', '~> 1.4'
  gem 'rspec-rails', '~> 6.0.0'
  gem 'factory_bot_rails'
  gem 'shoulda-matchers', '~> 5.0'
end

gem 'recaptcha'

group :development do
  gem 'capistrano', '~> 3.8'
  gem 'capistrano-rails', '~> 1.6'
  gem 'capistrano-rbenv', '~> 2.2'
  gem 'capistrano-passenger'
  gem 'capistrano-bundler', '~> 2.0'

  gem 'letter_opener'
  gem 'web-console'
end

group :production do
  gem 'pg'
end
