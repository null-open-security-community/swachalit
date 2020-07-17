require_relative 'chapters'
require_relative 'event_sessions'
require_relative 'event_registrations'
require_relative 'events'
require_relative 'authentications'
require_relative 'users'

module API
  class Swachalit < ::Grape::API

    rescue_from ApiExceptionAuthenticationFailure do |error|
      error!('Authentication required!', 401)
    end

    rescue_from ArgumentError do |error|
      error!('Invalid argument error', 500)
    end

    rescue_from ActiveRecord::RecordNotFound do
      error!('Record not found', 404)
    end

    rescue_from ActiveRecord::RecordInvalid do |error|
      error!('Record invalid', 400)
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
