require_relative 'chapter'
require_relative 'event'

module API
  class Swachalit < ::Grape::API

    mount ::API::Chapter  => '/'
    mount ::API::Event    => '/'

  end
end