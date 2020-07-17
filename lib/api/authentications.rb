require_relative 'helper'

module API
  class Authentications < Grape::API
    include ::API::Helper

    version 'v1', using: :header, vendor: 'swachalit'
    format :json

    resource :authentications do
      desc 'Authenticate by email and password'
      params do
        requires :email, type: String, desc: 'Email address for authentication'
        requires :password, type: String, desc: 'Password for authentication'
        requires :client_name, type: String, desc: 'The client name - Example: web-v2'
      end
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

      desc '[WIP] Authenticate by OpenID token from trusted providers'
      params do
        requires :token, type: String, desc: 'OpenID compliant JWT Token'
      end
      post '/:provider/token' do
        error!('401 Unauthorized', 401)
      end
    end

  end
end
