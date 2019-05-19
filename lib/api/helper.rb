module API
  module Helper

    extend ::Grape::API::Helpers

    def current_user
      warden = env["warden"]
      @current_user ||= warden.authenticate
    end

    def authenticated?
      !! current_user
    end

  end
end