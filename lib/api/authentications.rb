require_relative 'helper'

module API
  class Authentications < Grape::API
    include ::API::Helper

    version 'v1', using: :header, vendor: 'swachalit'
    format :json

    resource :authentications do
      desc 'Authenticate by email and password'
      post 'password' do
        user = User.find_for_authentication(email: params[:email])
        if user and user.valid_password?(params[:password])
          token = user.create_api_token(params[:client_name], request)
          token.set_active!

          { token: token.token, expire_at: token.expire_at }
        else
          error!('401 Unauthorized', 401)
        end
      end

      desc 'Authenticate by OpenID token from trusted providers'
      post '/:provider/token' do
        error!('401 Unauthorized', 401)
      end
    end

  end
end
