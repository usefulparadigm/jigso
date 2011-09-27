require 'httparty'
# require 'hashie'

class Diffbot
  include HTTParty
  # include Hashie
  TOKEN = "7469e95d74f88fc2519f46885d3a0d1b"
  base_uri "http://www.diffbot.com/api"
  default_params :token => TOKEN

  # http://www.diffbot.com/docs/api/article

  def self.fetch(url, options={})
    # Mash[get('/article', :query => { :url => url })]
    get('/article', :query => { :url => url })
  end
  
end