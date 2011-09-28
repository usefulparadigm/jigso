# require 'openid/store/filesystem' 

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, Settings.api.twitter.consumer_key, Settings.api.twitter.consumer_secret
  provider :facebook, Settings.api.facebook.app_id, Settings.api.facebook.app_secret #, {:client_options => {:ssl => {:ca_path => "/opt/local/etc/openssl"}}}
end
