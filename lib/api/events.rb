require_relative 'helper'
require_relative 'entities/event_entity'

module API
  class Events < Grape::API
    include ::API::Helper

    version 'v1', using: :header, vendor: 'swachalit'
    format :json

    resource :events do
      desc 'Returns list of upcoming public events'
      params do
        optional :page, type: Integer, desc: 'Page number for pagination'
        optional :per_page, type: Integer, desc: 'Per page count for pagination'
        optional :all, type: Boolean, desc: 'Show past events as well (Default: false)'
      end
      get do
        page = (params[:page] || 0).to_i
        per_page = [params[:per_page].to_i, 100].max

        if params[:all]
          events = ::Event.public_events
        else
          events = ::Event.future_public_events
        end

        present events.page(page).per(per_page), \
          with: EventEntity
      end
    end

  end
end
