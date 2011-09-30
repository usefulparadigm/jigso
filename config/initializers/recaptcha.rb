Recaptcha.configure do |config|
  config.public_key  = Settings.api.recaptcha.public_key
  config.private_key = Settings.api.recaptcha.private_key
  # config.proxy = 'http://myrpoxy.com.au:8080'
end