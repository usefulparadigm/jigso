# http://stackoverflow.com/questions/4098563/toggling-devise-authentication-modules-per-controller-action

require 'devise/strategies/base'
require 'devise/strategies/token_authenticatable'

module Devise
  module Strategies
    class TokenAuthenticatable < Authenticatable
      private
      # disable token access for any controller and any verb except api call.
      def valid_request?
        # false
        params[:controller] =~ /^api/
        # params[:controller] == "photos" && params[:action] == "create"
      end
    end
  end
end
