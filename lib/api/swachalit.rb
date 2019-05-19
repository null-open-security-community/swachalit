require_relative 'chapter'

module API
  class Swachalit < ::Grape::API

    mount ::API::Chapter => '/'

  end
end