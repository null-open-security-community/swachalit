require_relative 'helper'

module API
  class Events < Grape::API
    include ::API::Helper

    version 'v1', using: :header, vendor: 'swachalit'
    format :json

    resource :events do
      desc 'Returns list of upcoming public events'
      get do
        ::Event.future_public_events
      end
    end

  end
end
