Recaptcha.configure do |config|
  config.site_key  = ENV['RECAPTCHA_BOARDGAMES_SITE_KEY']
  config.secret_key = ENV['RECAPTCHA_BOARDGAMES_SECRET_KEY']
end
