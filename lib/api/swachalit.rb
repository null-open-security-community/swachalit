require_relative 'chapters'
require_relative 'events'

module API
  class Swachalit < ::Grape::API

    mount ::API::Chapters
    mount ::API::Events

  end
end
