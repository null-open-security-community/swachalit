require_relative 'chapters'
require_relative 'events'
require_relative 'authentications'

module API
  class Swachalit < ::Grape::API

    mount ::API::Chapters
    mount ::API::Events
    mount ::API::Authentications

  end
end
