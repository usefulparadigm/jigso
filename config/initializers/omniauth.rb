Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, Settings.api.twitter.consumer_key, Settings.api.twitter.consumer_secret
  # provider :facebook, 'APP_ID', 'APP_SECRET'
  # provider :linked_in, 'CONSUMER_KEY', 'CONSUMER_SECRET'
end
