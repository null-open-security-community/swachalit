module API
  module Helper

    extend ::Grape::API::Helpers

    def warden
      warden = env["warden"]
    end

    def authenticate_api_user!
      token = request.headers['Authorization'].to_s.gsub(/\ABearer\s/i, '')
      token = ::UserApiToken.active.find_by(token: token).presence

      if token and token.user
        warden.set_user(token.user, scope: :api)
      else
        raise ApiExceptionAuthenticationFailure, "Authentication required!"
      end
    end

    def current_user
      @current_user ||= warden.user(:api)
    end

    def authenticated?
      !! current_user
    end

  end
end

module Grape
  class Request
    def remote_ip
      env['REMOTE_ADDR']
    end
  end
end

class ApiExceptionAuthenticationFailure < StandardError
end
