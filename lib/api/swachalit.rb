require_relative 'chapters'
require_relative 'events'
require_relative 'authentications'
require_relative 'users'

module API
  class Swachalit < ::Grape::API

    rescue_from ApiExceptionAuthenticationFailure do |error|
      error!('Authentication required!', 401)
    end

    mount ::API::Chapters
    mount ::API::Events
    mount ::API::Authentications
    mount ::API::Users

    add_swagger_documentation \
    mount_path: '/docs',
    info: {
      title: 'Swachalit API',
      description: 'The null Swachalit API'
    }

  end
end
